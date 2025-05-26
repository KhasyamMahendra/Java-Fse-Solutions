// =============================
// 1. Basic Setup & Logging
// =============================
console.log("Welcome to the Community Portal");

window.addEventListener("load", () => {
  alert("Page is fully loaded!");
});

// =============================
// 2. Syntax, Data Types, and Operators
// =============================
const eventName = "Tech Meetup";
const eventDate = "2025-06-15";
let availableSeats = 50;

console.log(`Upcoming Event: ${eventName} on ${eventDate}`);
availableSeats--;
console.log(`Seats left: ${availableSeats}`);

// =============================
// 3. Conditionals, Loops & Error Handling
// =============================
const events = [
  { name: "Music Festival", date: "2025-06-12", seats: 20 },
  { name: "Tech Meetup", date: "2025-06-15", seats: 0 },
  { name: "Sports Day", date: "2025-06-20", seats: 30 },
];

function displayUpcomingEvents() {
  events.forEach((event) => {
    if (new Date(event.date) >= new Date() && event.seats > 0) {
      console.log(
        `Event: ${event.name}, Date: ${event.date}, Seats: ${event.seats}`
      );
    }
  });
}

try {
  displayUpcomingEvents();
} catch (error) {
  console.error("Error displaying events: ", error);
}

// =============================
// 4. Functions, Closures & Higher-Order Functions
// =============================
function registerUser(userName, eventCategory) {
  return function () {
    console.log(`${userName} registered for ${eventCategory}`);
  };
}

const registerJohn = registerUser("John Doe", "Tech");
registerJohn();

function filterEventsByCategory(category, callback) {
  return events.filter((event) => event.name.includes(category)).map(callback);
}

filterEventsByCategory("Music", (event) =>
  console.log(`Filtered Event: ${event.name}`)
);

// =============================
// 5. Objects & Prototypes
// =============================
class Event {
  constructor(name, date, seats) {
    this.name = name;
    this.date = date;
    this.seats = seats;
  }
  checkAvailability() {
    return this.seats > 0 ? "Available" : "Sold Out";
  }
}

const codingBootcamp = new Event("Coding Bootcamp", "2025-06-25", 40);
console.log(codingBootcamp.checkAvailability());

// =============================
// 6. Arrays & Methods
// =============================
events.push({ name: "Art Fair", date: "2025-06-22", seats: 25 });
console.log(events.map((event) => `Upcoming: ${event.name}`));

// =============================
// 7. DOM Manipulation
// =============================
document.addEventListener("DOMContentLoaded", () => {
  const eventSection = document.querySelector("#events");
  events.forEach((event) => {
    let div = document.createElement("div");
    div.className = "eventCard";
    div.textContent = `${event.name} - ${event.date}`;
    eventSection.appendChild(div);
  });
});

// =============================
// 8. Event Handling
// =============================
document.querySelector("#eventForm").addEventListener("submit", (event) => {
  event.preventDefault();
  alert("Thank you for registering!");
});

document.querySelector("#eventType").addEventListener("change", function () {
  console.log(`Event fee updated for: ${this.value}`);
});

document.querySelector("#searchBox").addEventListener("keydown", (event) => {
  console.log(`Searching for: ${event.key}`);
});

// =============================
// 9. Async JS, Fetch API
// =============================
async function fetchEvents() {
  try {
    let response = await fetch("https://api.mockevents.com/events");
    let data = await response.json();
    console.log("Fetched Events: ", data);
  } catch (error) {
    console.error("API fetch error", error);
  }
}

fetchEvents();

// =============================
// 10. Modern JavaScript Features
// =============================
const eventDetails = { name: "Tech Meetup", location: "City Hall" };
const { name, location } = eventDetails;
console.log(`Event Name: ${name}, Location: ${location}`);

const clonedEvents = [...events];
console.log("Cloned Events List:", clonedEvents);

// =============================
// 11. Form Handling
// =============================
document.querySelector("#eventForm").addEventListener("submit", (event) => {
  event.preventDefault();
  const formData = new FormData(event.target);
  console.log("Form Data:", Object.fromEntries(formData));
});

// =============================
// 12. AJAX & Fetch API
// =============================
function sendRegistration() {
  fetch("https://api.mockserver.com/register", {
    method: "POST",
    body: JSON.stringify({ name: "John Doe", event: "Tech Meetup" }),
    headers: { "Content-Type": "application/json" },
  })
    .then((response) => response.json())
    .then((data) => console.log("Registration Successful", data))
    .catch((error) => console.error("Registration Failed", error));

  setTimeout(() => console.log("Processing Registration..."), 2000);
}

sendRegistration();

// =============================
// 13. Debugging & Testing
// =============================
console.log("Testing Debugging...");
debugger;

// =============================
// 14. jQuery Integration
// =============================
$(document).ready(() => {
  $("#registerBtn").click(() => {
    alert("Registered via jQuery!");
  });

  $(".eventCard").fadeIn().fadeOut();
});
//One significant benefit of migrating to front-end frameworks like react or vue is their component-based architecture
