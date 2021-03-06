<%@ page import="entity.Member" %>
<%@ page import="dao.sql.MemberDAOSQL" %>
<%@ page import="service.UserService" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.Crew" %>
<%@ page import="service.CrewService" %>
<%@ page import="entity.Airport" %>
<%@ page import="service.AirportService" %>
<%@ page import="entity.Flight" %>
<%@ page import="service.FlightService" %><%--
  
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Member member = (Member) request.getSession().getAttribute("member");
%>
<html>
<head>
    <title>main.jsp</title>
</head>
<body>
<h1>Airline</h1>
<%
    // Header
    if (member == null) {
        out.print("<p>\n" +
                "        <a href=\"signin\">Sign In</a>\n" +
                "    </p>\n" +
                "    <p>\n" +
                "        <a href=\"signup\">Sign Up</a>\n" +
                "    </p>");
    } else {
        out.print("<p>" + member.email + "</p>");
        out.print("<form action=\"" + request.getContextPath() + "\" method=\"post\">\n" +
                " <input type=\"hidden\" name=\"action\" value=\"logout\" hidden/>\n" +
                " <input type=\"submit\" value=\"Log Out\"/>\n" +
                "    </form>");
    }
%>
<%
    // Crew creation (supervisor)
    // Crew is 2 pilots, navigator, radioman, 3 stewardesses
    if (member != null && member.role == Member.Role.SUPERVISOR) {
        List<Member> pilots = UserService.getPilots();
        List<Member> navigators = UserService.getNavigators();
        List<Member> radiomans = UserService.getRadiomans();
        List<Member> stewardesses = UserService.getStewardesses();

        out.print("<h1>Crew creator</h1>");
        out.print("<form action=\"\" + request.getContextPath() + \"\" method=\"post\">\n" +
                "    <table>\n" +
                "        <tr>\n" +
                "            <td>\n" +
                "                <label for=\"pilot0\">Pilot 1</label>\n" +
                "                <select id=\"pilot0\" name=\"pilot0\">");
        for (Member m : pilots) {
            String name = m.firstName + " " + m.middleName + " " + m.lastName;
            out.print("<option value=\"" + m.id + "\">" + name + "</option>");
        }
        out.print("</select>\n" +
                "            </td>\n" +
                "        </tr>\n" +
                "        <tr>\n" +
                "            <td>\n" +
                "                <label for=\"pilot1\">Pilot 2</label>\n" +
                "                <select id=\"pilot1\" name=\"pilot1\">");
        for (Member m : pilots) {
            String name = m.firstName + " " + m.middleName + " " + m.lastName;
            out.print("<option value=\"" + m.id + "\">" + name + "</option>");
        }
        out.print("</select>\n" +
                "            </td>\n" +
                "        </tr>\n" +
                "        <tr>\n" +
                "            <td>\n" +
                "                <label for=\"navigator\">Navigator</label>\n" +
                "                <select id=\"navigator\" name=\"navigator\">");
        for (Member m : navigators) {
            String name = m.firstName + " " + m.middleName + " " + m.lastName;
            out.print("<option value=\"" + m.id + "\">" + name + "</option>");
        }
        out.print("</select>\n" +
                "            </td>\n" +
                "        </tr>\n" +
                "        <tr>\n" +
                "            <td>\n" +
                "                <label for=\"radioman\">Radioman</label>\n" +
                "                <select id=\"radioman\" name=\"radioman\">");
        for (Member m : radiomans) {
            String name = m.firstName + " " + m.middleName + " " + m.lastName;
            out.print("<option value=\"" + m.id + "\">" + name + "</option>");
        }
        out.print("</select>\n" +
                "            </td>\n" +
                "        </tr>\n" +
                "        <tr>\n" +
                "            <td>\n" +
                "                <label for=\"stewardess0\">Stewardess 1</label>\n" +
                "                <select id=\"stewardess0\" name=\"stewardess0\">");
        for (Member m : stewardesses) {
            String name = m.firstName + " " + m.middleName + " " + m.lastName;
            out.print("<option value=\"" + m.id + "\">" + name + "</option>");
        }
        out.print("</select>\n" +
                "            </td>\n" +
                "        </tr>\n" +
                "        <tr>\n" +
                "            <td>\n" +
                "                <label for=\"stewardess1\">Stewardess 2</label>\n" +
                "                <select id=\"stewardess1\" name=\"stewardess1\">");
        for (Member m : stewardesses) {
            String name = m.firstName + " " + m.middleName + " " + m.lastName;
            out.print("<option value=\"" + m.id + "\">" + name + "</option>");
        }
        out.print("</select>\n" +
                "            </td>\n" +
                "        </tr>\n" +
                "        <tr>\n" +
                "            <td>\n" +
                "                <label for=\"stewardess2\">Stewardess 3</label>\n" +
                "                <select id=\"stewardess2\" name=\"stewardess2\">");
        for (Member m : stewardesses) {
            String name = m.firstName + " " + m.middleName + " " + m.lastName;
            out.print("<option value=\"" + m.id + "\">" + name + "</option>");
        }
        out.print("</select>\n" +
                "            </td>\n" +
                "        </tr>\n" +
                "    </table>\n" +
                "    <input type=\"hidden\" name=\"action\" value=\"addcrew\" hidden/>\n" +
                "    <input type=\"submit\" value=\"Submit\"/>\n" +
                "</form>");
    }
%>
<h1>Crews</h1>
<%
    //Crews
    List<Crew> crews = CrewService.getAll();
    for (Crew crew : crews) {
        String names = "";
        for (Member m : crew.members) {
            String name = m.firstName + " " + m.middleName + " " + m.lastName;
            names += name + ", ";
        }
        out.print("<p>Crew " + crew.id + " (" + names + ")</p>");
    }
%>
<%
    // Flight creation (admin)
    if (member != null && member.role == Member.Role.ADMIN) {
        List<Airport> airports = AirportService.getAll();
        out.print("<h1>Flight creator</h1>");
        out.print("<form action=\"\" + request.getContextPath() + \"\" method=\"post\">\n" +
                "    <table>\n" +
                "        <tr>\n" +
                "            <td>\n" +
                "                <label for=\"departure\">Departure</label>\n" +
                "                <select id=\"departure\" name=\"departure\">");
        for (Airport airport : airports) {
            out.print("<option value=\"" + airport.id + "\">" + airport.name + "</option>");
        }
        out.print("</select>\n" +
                "            </td>\n" +
                "        </tr>\n" +
                "        <tr>\n" +
                "            <td>\n" +
                "                <label for=\"arrival\">Arrival</label>\n" +
                "                <select id=\"arrival\" name=\"arrival\">");
        for (Airport airport : airports) {
            out.print("<option value=\"" + airport.id + "\">" + airport.name + "</option>");
        }
        out.print("</select>\n" +
                "            </td>\n" +
                "        </tr>");
        out.print("<tr>\n" +
                "                            <td>" +
                "                                <label for=\"crew\">Crew</label>" +
                "                                <select id=\"crew\" name=\"crew\">\"");
        for (Crew crew : crews) {
            out.print("<option value=\"" + crew.id + "\">" + crew.id + "</option>");
        }
        out.print("</select>\n" +
                "            </td>\n" +
                "        </tr>");
        out.print("<tr>\n" +
                "            <td>\n" +
                "            <label for=\\\"date\\\">Date</label>" +
                "                <input type=\"datetime-local\" name=\"date\" required/>\n" +
                "            </td>\n" +
                "        </tr>");
        out.print("<tr>\n" +
                "            <td>\n" +
                "            <label for=\\\"seats\\\">Seats</label>" +
                "                <input type=\"number\" name=\"seats\" required/>\n" +
                "            </td>\n" +
                "        </tr>");
        out.print("</table>");
        out.print("<input type=\"hidden\" name=\"action\" value=\"addflight\" hidden/>\n" +
                "    <input type=\"submit\" value=\"Submit\"/>\n" +
                "</form>");
    }
%>
<h1>Flights</h1>
<%
    //Flights
    List<Flight> flights = FlightService.getAll();
    for (Flight flight : flights) {
        String departureDesc = flight.departure.name + ", " + flight.departure.country.name + ", " + flight.departure.city.name;
        String arrivalDesc = flight.arrival.name + ", " + flight.arrival.country.name + ", " + flight.arrival.city.name;

        out.print("<p>Flight " + flight.id + "</p>");
        out.print("<p>- DEPARTURE: " + departureDesc + "</p>");
        out.print("<p>- ARRIVAL: " + arrivalDesc + "</p>");
        out.print("<p>- FLIGHT TIME: " + flight.date.toString() + "</p>");
        out.print("<p>- SEATS: " + flight.seats + "</p>");
    }
%>
</body>
</html>
