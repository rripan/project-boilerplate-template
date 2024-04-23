from flask import Blueprint, jsonify, request

event_bp = Blueprint('event', __name__)

# Dummy data for demonstration purposes
events = [
    {'id': 1, 'description': 'Open House', 'event_date': '2023-06-01'},
    {'id': 2, 'description': 'Campus Tour', 'event_date': '2023-07-15'}
]

@event_bp.route('/events', methods=['GET'])
def get_events():
    return jsonify(events)

@event_bp.route('/events/<int:event_id>', methods=['GET'])
def get_event(event_id):
    event = next((e for e in events if e['id'] == event_id), None)
    if event:
        return jsonify(event)
    else:
        return jsonify({'error': 'Event not found'}), 404

@event_bp.route('/events', methods=['POST'])
def create_event():
    data = request.get_json()
    new_event = {
        'id': len(events) + 1,
        'description': data['description'],
        'event_date': data['event_date']
    }
    events.append(new_event)
    return jsonify(new_event), 201

@event_bp.route('/events/<int:event_id>', methods=['PUT'])
def update_event(event_id):
    data = request.get_json()
    event = next((e for e in events if e['id'] == event_id), None)
    if event:
        event['description'] = data['description']
        event['event_date'] = data['event_date']
        return jsonify(event)
    else:
        return jsonify({'error': 'Event not found'}), 404

@event_bp.route('/events/<int:event_id>', methods=['DELETE'])
def delete_event(event_id):
    global events
    event = next((e for e in events if e['id'] == event_id), None)
    if event:
        events.remove(event)
        return jsonify({'message': 'Event deleted'})
    else:
        return jsonify({'error': 'Event not found'}), 404

@event_bp.route('/events/<int:event_id>/attendees', methods=['GET'])
def get_event_attendees(event_id):
    # Implement logic to retrieve attendees for the given event_id
    return jsonify([])