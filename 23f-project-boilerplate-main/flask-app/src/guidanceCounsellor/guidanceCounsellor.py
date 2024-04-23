from flask import Blueprint, jsonify, request

guidance_counsellor_bp = Blueprint('guidance_counsellor', __name__)

# Dummy data for demonstration purposes
guidance_counsellors = [
    {'id': 1, 'name': 'Alice Johnson', 'high_school': 'Central High'},
    {'id': 2, 'name': 'Bob Wilson', 'high_school': 'Northside High'}
]

@guidance_counsellor_bp.route('/guidance_counsellors', methods=['GET'])
def get_guidance_counsellors():
    return jsonify(guidance_counsellors)

@guidance_counsellor_bp.route('/guidance_counsellors/<int:counsellor_id>', methods=['GET'])
def get_guidance_counsellor(counsellor_id):
    counsellor = next((c for c in guidance_counsellors if c['id'] == counsellor_id), None)
    if counsellor:
        return jsonify(counsellor)
    else:
        return jsonify({'error': 'Guidance counsellor not found'}), 404

@guidance_counsellor_bp.route('/guidance_counsellors', methods=['POST'])
def create_guidance_counsellor():
    data = request.get_json()
    new_counsellor = {
        'id': len(guidance_counsellors) + 1,
        'name': data['name'],
        'high_school': data['high_school']
    }
    guidance_counsellors.append(new_counsellor)
    return jsonify(new_counsellor), 201

@guidance_counsellor_bp.route('/guidance_counsellors/<int:counsellor_id>', methods=['PUT'])
def update_guidance_counsellor(counsellor_id):
    data = request.get_json()
    counsellor = next((c for c in guidance_counsellors if c['id'] == counsellor_id), None)
    if counsellor:
        counsellor['name'] = data['name']
        counsellor['high_school'] = data['high_school']
        return jsonify(counsellor)
    else:
        return jsonify({'error': 'Guidance counsellor not found'}), 404

@guidance_counsellor_bp.route('/guidance_counsellors/<int:counsellor_id>', methods=['DELETE'])
def delete_guidance_counsellor(counsellor_id):
    global guidance_counsellors
    counsellor = next((c for c in guidance_counsellors if c['id'] == counsellor_id), None)
    if counsellor:
        guidance_counsellors.remove(counsellor)
        return jsonify({'message': 'Guidance counsellor deleted'})
    else:
        rreturn jsonify([])