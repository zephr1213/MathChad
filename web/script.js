
async function solveEquation() {
    const equation = document.getElementById('equation').value;
    const solution = await eel.solve_algebra_equation(equation)();
    if (solution) {
    Swal.fire("Solution Found", solution, "success");
    } else {
    Swal.fire("Error", "Failed to solve the equation.", "error");
    }
}