from flask import Flask, request, jsonify
from proxmoxer import ProxmoxAPI
from dotenv import load_dotenv
import json, os

app = Flask(__name__)

load_dotenv("conf.env")

PROXMOX_TOKEN_FRA_VALUE = os.getenv("PROXMOX_TOKEN_FRA_VALUE")
TOKEN_NAME = os.getenv("TOKEN_NAME")
USER = os.getenv("USER")
PROXMOX_SERVER_URL = os.getenv("PROXMOX_SERVER_URL")

proxmox = ProxmoxAPI(PROXMOX_SERVER_URL, user=USER, token_name=TOKEN_NAME, token_value=PROXMOX_TOKEN_FRA_VALUE, verify_ssl=False)

def update_Json_limitation_file_after_vm_creation(vm_data_json):
     
    with open('cyberRangeGen/tftest/jsonLimitation.txt', 'r') as file:
        limitation_data = json.load(file)
    
    available_ram_in_megabyte = int(limitation_data['resources']['availableRam'].replace('MB', ''))                     #MB
    available_cpu_cores = int(limitation_data['resources']['availableCPU_cores'].replace(' Core', ''))                  #INT
    available_disk_storage_in_gigabytes = int(limitation_data['resources']['available_disk_storage'].replace('GB', '')) #GB
    
    vm_ram_in_megabytes = int(vm_data_json['ram'])
    vm_cpu_cores = int(vm_data_json['cpus'])
    vm_disk_storage_in_gigabytes = int(vm_data_json['disk'])

    # print("vm_ram_in_megabytes "+vm_ram_in_megabytes)
    # print("vm_cpu_cores "+str(vm_cpu_cores))
    # print("vm_disk_storage_in_gigabytes "+vm_disk_storage_in_gigabytes)
    
    updated_ram = available_ram_in_megabyte - vm_ram_in_megabytes
    updated_cpu_cores = available_cpu_cores - vm_cpu_cores
    updated_disk_storage = available_disk_storage_in_gigabytes - vm_disk_storage_in_gigabytes
    
    # print("updated_cpu_cores "+str(updated_cpu_cores))

    if updated_ram < 0 or updated_cpu_cores < 0 or updated_disk_storage < 0:
        raise ValueError("Not enough resources available to create this VM.")
    
    limitation_data['resources']['availableRam'] = f"{updated_ram}MB"
    limitation_data['resources']['availableCPU_cores'] = f"{updated_cpu_cores} Core"
    limitation_data['resources']['available_disk_storage'] = f"{updated_disk_storage}GB"
    
    with open('JsonLimitation.txt', 'w') as file:
        json.dump(limitation_data, file, indent=4)
    
    #return limitation_data

def update_Json_limitation_file_after_vm_delete(vm_data_json):
    
    with open('cyberRangeGen/tftest/jsonLimitation.txt', 'r') as file:
        limitation_data = json.load(file)
    
    available_ram_in_megabyte = int(limitation_data['resources']['availableRam'].replace('MB', ''))                     #MB
    available_cpu_cores = int(limitation_data['resources']['availableCPU_cores'].replace(' Core', ''))                  #INT
    available_disk_storage_in_gigabytes = int(limitation_data['resources']['available_disk_storage'].replace('GB', '')) #GB
    
    vm_ram_in_byte = int(vm_data_json['ram'])
    vm_cpu_cores = int(vm_data_json['cpus'])
    vm_disk_storage_in_byte = int(vm_data_json['disk'])
    
    updated_ram = available_ram_in_megabyte + vm_ram_in_byte
    updated_cpu_cores = available_cpu_cores + vm_cpu_cores
    updated_disk_storage = available_disk_storage_in_gigabytes + vm_disk_storage_in_byte
    
    if updated_ram < 0 or updated_cpu_cores < 0 or updated_disk_storage < 0:
        raise ValueError("Not enough resources available to create this VM.")
    
    limitation_data['resources']['availableRam'] = f"{updated_ram}MB"
    limitation_data['resources']['availableCPU_cores'] = f"{updated_cpu_cores} Core"
    limitation_data['resources']['available_disk_storage'] = f"{updated_disk_storage}GB"
    
    with open('JsonLimitation.txt', 'w') as file:
        json.dump(limitation_data, file, indent=4)
    
    update_Json_limitation_file_after_vm_delete(vm_data_json)
    
    #return limitation_data


@app.route('/create_vm', methods=['POST'])
def create_vm():
    try:
        
        data = request.get_json()
        if not data:
            return jsonify({"status": "error", "message": "JSON not provided"}), 400

        required_fields = ['vm_id', 'vm_name']
        for field in required_fields:
            if field not in data:
                return jsonify({"status": "error", "message": f"Missing '{field}' field"}), 400

        if not isinstance(data['vm_id'], int) or not isinstance(data['vm_name'], str):
            return jsonify({"status": "error", "message": "data types not valid"}), 400

        vm_config = {
            'vmid': data['vm_id'],
            'name': data['vm_name'],
            # 'memory': data['vm_memory'],
            # 'cores': data['vm_cores'],
            # 'cpu': data['vm_cpu'],
            # 'net0': data['vm_net0'],
            # 'scsihw': data['vm_scsihw'],
            # 'scsi0': data['vm_scsi0'],
            # 'ide0': data['vm_ide0'],
            # 'ostype': data['vm_ostype'],
            # 'boot': data['vm_boot'],
            # 'bootdisk': data['vm_bootdisk'],
            # 'sockets': data['vm_sockets'],
            # 'agent': data['vm_agent'],
            # 'vga': data['vm_vga'],
            # 'serial0': data['vm_serial0'],
        }

        proxmox.nodes('pve').qemu.create(**vm_config)

        #update_Json_limitation_file_after_vm_creation(vm_config)

        return jsonify({"status": "success", "data": data}), 201

    except KeyError as e:
        return jsonify({"status": "error", "message": f"Campo mancante: {str(e)}"}), 400
    except Exception as e:
        return jsonify({"status": "error", "message": "Internal server error", "error_details": str(e)}), 500

@app.route('/scenario=pve/get_vms', methods=['GET'])
def get_scenario_vms():
    try:

        vms = proxmox.nodes('pve').qemu().get()
        return jsonify(vms), 200
    
    except Exception as e:
       
        return jsonify({
            "status": "error",
            "message": "Error retrieving VMs from the 'pve' node.",
            "error_details": str(e)
        }), 500

@app.route('/scenario=<scenario>/get_vms', methods=['GET'])
def get_resources(scenario):
    
    if not scenario:
        return jsonify({
            "status": "error",
            "message": "Missing or invalid scenario parameter."
        }), 400

    try:
        
        vms = proxmox.nodes(scenario).qemu().get()
        return jsonify(vms), 200
    
    except Exception as e:
        
        app.logger.error(f"Errore nel recupero delle VM per lo scenario '{scenario}': {e}")
        
        return jsonify({
            "status": "error",
            "message": f"Unable to retrieve VMs for scenario '{scenario}'.",
            "error_details": str(e)
        }), 500

@app.route('/scenario/get_vm/<identifier>', methods=['GET'])
def get_vm(identifier):
    try:
        vm_id = int(identifier)
        
        machines = proxmox.nodes('pve').qemu().get()
        
        for machine in machines:
            if machine.get('vmid') == vm_id:
                return jsonify(machine), 200
        
        return jsonify({"status": "error", "message": "VM not found", "identifier": identifier}), 404
    except ValueError:
        return jsonify({"status": "error", "message": "Invalid identifier. Must be an integer."}), 400
    except Exception as e:
        return jsonify({
            "status": "error",
            "message": "Error when connecting to Proxmox or retrieving VM.",
            "error_details": str(e)
        }), 500

@app.route('/delete_vm/<id_to_remove>', methods=['DELETE'])
def delete_vm(id_to_remove):
    try:
        
        if not id_to_remove.isdigit():
            app.logger.error(f"Invalid VM ID provided: {id_to_remove}")
            return jsonify({"error": "Invalid VM ID"}), 400
        
        node = 'pve'  
        app.logger.info(f"Attempting to delete VM with ID: {id_to_remove} on node: {node}")
        
        
        vms = proxmox.nodes(node).qemu.get()
        vm_ids = [str(vm['vmid']) for vm in vms]
        if id_to_remove not in vm_ids:
            app.logger.warning(f"VM with ID {id_to_remove} does not exist.")
            return jsonify({"error": f"VM with ID {id_to_remove} does not exist"}), 404
        
        
        proxmox.nodes(node).qemu(id_to_remove).delete()
        #update_Json_limitation_file_after_vm_delete(vm_data_json)
        app.logger.info(f"Successfully deleted VM with ID: {id_to_remove}")
        
        return jsonify({"success": True, "vm_removed": id_to_remove}), 200

    except Exception as e:
        app.logger.error(f"An error occurred while deleting VM {id_to_remove}: {e}")
        return jsonify({"error": "An internal error occurred", "details": str(e)}), 500

@app.route('/get_all_scenarios', methods=['GET'])
def get_all_scenarios():
    try:
        risorse = proxmox.nodes().get()
        return jsonify(risorse), 200
    except Exception as e:
        return jsonify({
            "status": "error",
            "message": "Unable to retrieve resources from the Proxmox server.",
            "error_details": str(e)
        }), 500

@app.route('/<scenario>/get_resources_in_state/<status>', methods=['GET'])
def get_resources_in_states(status):

    c=0
    tmp = proxmox.nodes('{scenario}').qemu().get()

    for vm in tmp:
        if vm['status'] == '{status}':
            c =c+1

@app.route('/pve/get_resources_in_state/stopped', methods=['GET'])
def get_resources_in_states_stopped():

    c=0
    tmp = proxmox.nodes('pve').qemu().get()

    for vm in tmp:
        if vm['status'] == 'stopped':
            c =c+1
    
    return {"stopped_vms":c} 

@app.route('/pve/get_resources_in_state/running', methods=['GET'])
def get_resources_in_states_running():

    c=0
    tmp = proxmox.nodes('pve').qemu().get()

    for vm in tmp:
        if vm['status'] == 'running':
            c =c+1
    
    return {"running_vms":c} 

@app.route('/pve/get_resources_in_state/paused', methods=['GET'])
def get_resources_in_states_paused():

    c=0
    tmp = proxmox.nodes('pve').qemu().get()

    for vm in tmp:
        if vm['status'] == 'paused':
            c =c+1
    
    return {"paused_vms":c} 

@app.route('/pve/get_resources_in_state/suspended', methods=['GET'])
def get_resources_in_states_suspended():

    c=0
    tmp = proxmox.nodes('pve').qemu().get()

    for vm in tmp:
        if vm['status'] == 'suspended':
            c =c+1
    
    return {"suspended_vms":c} 


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)
    
