import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentValue: Float = 300; // With "stable" keyword, it's stable/orthogonal persisted variable
  currentValue := 300;
  Debug.print(debug_show(currentValue));

  stable var startTime = Time.now();
  startTime := Time.now();
  Debug.print(debug_show(startTime));

  let id = 12567890; // let for constant, never change
  // Debug.print("Hello");
  // Debug.print(debug_show(id));

  public func topUp(amount: Float) { 
    // Without the "public" keyword, it's private method, only accessible in the class.
    // This's the "update" method since no "query" keyword, which updates canister status, hence more time consuming.
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };
  // topUp();

  public func withdraw(amount: Float) {
    // Nat is natural number which's a positive whole number, sometimes with a inclusion of zero.
    // Nat is a subtype of Int.
    let tempValue: Float = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("The amount to deduct is bigger than the current value.");
    }
  };

  // This is the "query" function, which is faster since no changing blockchain.
  public query func checkBalance(): async Float {
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS)); // assume 1% interest per second
    startTime := currentTime;
  };

}