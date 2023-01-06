var ticket_submission_form = document.querySelector("#ticket-submission-form");
var ticket_submission_button = document.querySelector("#ticket-submission-button");
var ticket_list = document.querySelector("#ticket-list");


ticket_submission_button.addEventListener("click", function() {
    createTicket();
});


function listTickets() {
    fetch('http://localhost:8080/tickets', 
          {credentials: 'include'
    }).then(function(response) {
        return response.json();
    }).then(function(tickets) {
        displayTicketList(tickets);
    });

}
function createTicket() {
    var encoded_body = grabFormValues();
    var duplicate = false;
    fetch('http://localhost:8080/tickets', {
        method: 'POST',
        credentials: 'include',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: encoded_body
    }).then(function(response) {
        if (response.status == 403) {
            duplicate = true;
        }
        return response.text();
    }).then(function(data) {
        if (duplicate) {
            alert(data);
        }
        else {
            clearFormValues();
            listTickets();
        }
    });
}

function displayTicketList(tickets) {
    clearTickets();
    tickets.forEach(function (ticket) {
        var ticket_div = document.createElement("div");
        
        var entrant_name = ticket["entrant_name"];
        var entrant_age = ticket["entrant_age"].toString();
        var guest_name = ticket["guest_name"];
        var ticket_string = entrant_name + " (age " + entrant_age + "), with " + guest_name;
        ticket_div.className = "ticket";
        ticket_div.innerHTML = ticket_string;
        
        var day_of_week = new Date().getDay();
        if (ticket["random_token"] == day_of_week) {
            ticket_div.className += " golden-ticket";
        }
        
        ticket_list.appendChild(ticket_div);
    });
}

function clearTickets() {
    ticket_list.innerHTML = "";
}

function grabFormValues() {
    encoded_body = "";
    var input_fields = ticket_submission_form.getElementsByClassName("input");
    for (var i = 0; i < input_fields.length; i++) {
        var input_field = input_fields[i];
        var key = input_field.name;
        var value = input_field.value;
        var encoded_pair = key + "=" + encodeURIComponent(value);
        encoded_body += (encoded_pair + "&");
    }
    
    return encoded_body.slice(0, -1);
}
function clearFormValues() {
    var input_fields = ticket_submission_form.getElementsByClassName("input");
    for (var i = 0; i < input_fields.length; i++) {
        var input_field = input_fields[i];
        input_field.value = "";
    }
}


function onPageLoad() {
    listTickets();
}
onPageLoad();
