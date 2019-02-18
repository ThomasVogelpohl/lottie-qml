// script.js
var window
// var lottieJs = Qt.include("factorial.js")


function showCalculations(value) {

    window = {

    }

    var lottieJs = Qt.include("factorial.js")

    console.log(
        "Call factorial() from script.js:",
        factorial(value));
}

function deleteFactorial() {
    console.log(
        "Delete");
    // delete showCalculations.factorial
    // delete showCalculations.window
    // delete showCalculations.lottieJs
}
