curl -X POST http://localhost:51051/v1/reservations \
  -H 'Content-Type: application/json' \
  -d '{
            "title": "Lunchmeeting2",
            "venue": "JDriven Coltbaan 3",
            "room": "atrium",
            "timestamp": "2018-10-10T11:12:13",
            "attendees": [
                {
                    "ssn": "1234567890",
                    "firstName": "Jimmy",
                    "lastName": "Jones"
                },
                {
                    "ssn": "9999999999",
                    "firstName": "Dennis",
                    "lastName": "Richie"
                }
            ]
        }'
echo
curl "http://localhost:51051/v1/reservations"
echo
curl "http://localhost:51051/v1/reservations?room=atrium"
