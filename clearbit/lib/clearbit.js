// 1. Register an account on clearbit and add below your api key
const authorization = "Bearer sk_a32c...";

// 2. Add event listener to the form
const form = document.getElementById('clearbitForm');
form.addEventListener('submit', (event) => {
  // 3. Prevent the page from reloading
  event.preventDefault();
  // 4. Read email from the form input
  const email = document.getElementById('clearbitEmail').value;
  // 5. Send an AJAX request to the Clearbit API using the fetch API
  callClearbitApi(email);
});

const callClearbitApi = (email) => {
  const url = `https://person.clearbit.com/v2/combined/find?email=${email}`;
  fetch(url, { headers: { authorization: authorization } })
    .then(response => response.json())
    .then((data) => {
      // 6. Read the json returned
      const person = data.person;
      // 7. Display the results in the table
      document.getElementById('userName').innerText = person.name.fullName;
      document.getElementById('userEmail').innerText = person.email;;
      document.getElementById('userBio').innerText = person.bio;
      document.getElementById('userLocation').innerText = person.location;
    });
};
