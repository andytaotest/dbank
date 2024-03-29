import { dbank } from "../../declarations/dbank";

window.addEventListener("load", async function() {
  // console.log("Finished loading.");
  update();
});

document.querySelector("form").addEventListener("submit", async function() {
  // console.log("Submitted.");
  // Get rid of the default button behaviour while submitting
  event.preventDefault();
  // Get a handler of the button
  const button = event.target.querySelector("#submit-btn"); // event.target is to get the form
  // Get the values on the screen
  const topUpAmount = parseFloat(document.getElementById("input-amount").value);
  const withdrawAmount = parseFloat(document.getElementById("withdrawal-amount").value);
  // Disable the button
  button.setAttribute("disabled", true);
  // Top up
  if (document.getElementById("input-amount").value.length != 0) {
    await dbank.topUp(topUpAmount);
  }
  // Withdraw
  if (document.getElementById("withdrawal-amount").value.length != 0) {
    await dbank.withdraw(withdrawAmount);
  }
  // Calculate compound
  await dbank.compound();
  // Display the latest balance 
  update();
  // Clear the fields
  document.getElementById("input-amount").value = "";
  document.getElementById("withdrawal-amount").value = "";
  // Enable the button
  button.removeAttribute("disabled");
});

async function update() {
  const currentAmount = await dbank.checkBalance();
  document.getElementById("value").innerHTML = currentAmount.toFixed(2);
};