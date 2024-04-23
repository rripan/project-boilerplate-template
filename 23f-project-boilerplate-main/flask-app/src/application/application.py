from flask import Blueprint, jsonify, request

application_bp = Blueprint('application', __name__)

# Dummy data for demonstration purposes
applications = [
    {'id': 1, 'applicant_id': 1, 'submission_date': '2023-05-01', 'status': 'Submitted'},
    {'id': 2, 'applicant_id': 2, 'submission_date': '2023-05-15', 'status': 'Accepted'}
]

@application_bp.route('/applications', methods=['GET'])
def get_applications():
    return jsonify(applications)

@application_bp.route('/applications/<int:application_id>', methods=['GET'])
def get_application(application_id):
    application = next((a for a in applications if a['id'] == application_id), None)
    if application:
        return jsonify(application)
    else:
        return jsonify({'error': 'Application not found'}), 404

@application_bp.route('/applications', methods=['POST'])
def create_application():
    data = request.get_json()
    new_application = {
        'id': len(applications) + 1,
        'applicant_id': data['applicant_id'],
        'submission_date': data['submission_date'],
        'status': data['status']
    }
    applications.append(new_application)
    return jsonify(new_application), 201

@application_bp.route('/applications/<int:application_id>', methods=['PUT'])
def update_application(application_id):
    data = request.get_json()
    application = next((a for a in applications if a['id'] == application_id), None)
    if application:
        application['applicant_id'] = data['applicant_id']
        application['submission_date'] = data['submission_date']
        application['status'] = data['status']
        return jsonify(application)
    else:
        return jsonify({'error': 'Application not found'}), 404

@application_bp.route('/applications/<int:application_id>', methods=['DELETE'])
def delete_application(application_id):
    global applications
    application = next((a for a in applications if a['id'] == application_id), None)
    if application:
        applications.remove(application)
        return jsonify({'message': 'Application deleted'})
    else:
        return jsonify({'error': 'Application not found'}), 404

@application_bp.route('/applications/<int:application_id>/documents', methods=['GET'])
def get_application_documents(application_id):
    # Implement logic to retrieve documents for the given application_id
    return jsonify([])