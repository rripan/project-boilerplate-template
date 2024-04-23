from flask import Blueprint, jsonify, request
from src import db

# Create the blueprint
applicant_bp = Blueprint('applicant', __name__)

# Sample data storage: consider using a database instead
applicants = [
    {'id': 1, 'name': 'John Doe', 'high_school': 'ABC High School'},
    {'id': 2, 'name': 'Jane Smith', 'high_school': 'XYZ High School'}
]

# Route to get a list of all applicants
@applicant_bp.route('/applicants', methods=['GET'])
def get_applicants():
    # Return the list of applicants as a JSON response
    return jsonify(applicants)

# Route to get details of a specific applicant
@applicant_bp.route('/applicants/<int:applicant_id>', methods=['GET'])
def get_applicant(applicant_id):
    # Find the applicant with the given ID
    applicant = next((a for a in applicants if a['id'] == applicant_id), None)
    if applicant:
        # Return the applicant as a JSON response if found
        return jsonify(applicant)
    else:
        # Return an error response if the applicant is not found
        return jsonify({'error': 'Applicant not found'}), 404

# Route to create a new applicant
@applicant_bp.route('/applicants', methods=['POST'])
def create_applicant():
    # Get data from the request body
    data = request.get_json()
    
    # Create a new applicant with the provided data
    new_applicant = {
        'id': len(applicants) + 1,
        'name': data['name'],
        'high_school': data['high_school']
    }
    
    # Add the new applicant to the list of applicants
    applicants.append(new_applicant)
    
    # Return the new applicant as a JSON response with a 201 status code
    return jsonify(new_applicant), 201

# Route to update an existing applicant
@applicant_bp.route('/applicants/<int:applicant_id>', methods=['PUT'])
def update_applicant(applicant_id):
    # Get data from the request body
    data = request.get_json()
    
    # Find the applicant with the given ID
    applicant = next((a for a in applicants if a['id'] == applicant_id), None)
    
    # If the applicant is found, update their details
    if applicant:
        applicant['name'] = data['name']
        applicant['high_school'] = data['high_school']
        return jsonify(applicant)
    else:
        # Return an error response if the applicant is not found
        return jsonify({'error': 'Applicant not found'}), 404

# Route to delete an existing applicant
@applicant_bp.route('/applicants/<int:applicant_id>', methods=['DELETE'])
def delete_applicant(applicant_id):
    global applicants
    
    # Find the applicant with the given ID
    applicant = next((a for a in applicants if a['id'] == applicant_id), None)
    
    # If the applicant is found, remove them from the list and return a success message
    if applicant:
        applicants.remove(applicant)
        return jsonify({'message': 'Applicant deleted'})
    else:
        # Return an error response if the applicant is not found
        return jsonify({'error': 'Applicant not found'}), 404

# Route to get a list of applications for a specific applicant
@applicant_bp.route('/applicants/<int:applicant_id>/applications', methods=['GET'])
def get_applicant_applications(applicant_id):
    # Implement the logic to retrieve applications for the given applicant ID
    return jsonify([])  # Return an empty list for now, adjust as needed

