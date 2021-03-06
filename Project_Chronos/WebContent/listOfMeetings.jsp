<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String meetingIds = (String)request.getAttribute("meetingIds");
   meetingIds = "'" + meetingIds + "'";
   String endpoint = "'Result'";
   String username = (String)request.getAttribute("username");
   username = "'" + username + "'";
   int hostId = (int)request.getAttribute("hostId");
   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Chronos</title>
		<link rel="stylesheet" type="text/css" href="listOfMeetings.css">
	</head>
	<body onload="connectToServer()">
		<div id="outerContainer">
			<div id="header">
				<p>All meetings:</p>
			</div>
			<div id="meetingsDiv">
			</div>
			<button><a id="addNewMeetingButton">Add New Meeting</a></button>
		</div>
		<div id = dummy ></div>
	</body>
	<script>
	var socket;
	function connectToServer() {
		socket = new WebSocket("ws://localhost:8080/Project_Chronos/ws");
		socket.onopen = function(event) {
			// document.getElementById("dummy").innerHTML += "Connected!";
		}
		socket.onmessage = function(event) {
			document.getElementById("dummy").innerHTML += event.data + "<br />";
		}
		socket.onclose = function(event) {
			// document.getElementById("dummy").innerHTML += "Disconnected!";
		}
	}
	
		var meetingIds = <%= meetingIds %>
		var meetings = meetingIds.split(",");
		if (meetingIds === null || meetingIds === " " || meetingIds === "" || meetingIds === "null") {
			document.getElementById("meetingsDiv").innerHTML = "<p>You have no meetings</p>";
		} else {
			for (i in meetings) {
				var aMeeting = document.createElement("a");
				aMeeting.href = <%= endpoint %> + "?meetingId=" + meetings[i];
				var meetingDiv = document.createElement("div");
				meetingDiv.classList.add("meetingDiv");
				var pMeeting = document.createElement("p");
				var meetingText = document.createTextNode("Meeting ID: " + meetings[i]);
				pMeeting.appendChild(meetingText);
				meetingDiv.appendChild(pMeeting);
				aMeeting.appendChild(meetingDiv);
				document.getElementById("meetingsDiv").appendChild(aMeeting);
			}
		}
		document.getElementById("addNewMeetingButton").href = "newMeetingPage.jsp?username=" + <%= username %> + "&hostId=" + <%= hostId %>; 
	</script>
</html>
