import app from "./app.js";

const { PORT } = process.env;

app.listen(PORT);
console.log("Servidor ejecutando en el puerto", PORT);
