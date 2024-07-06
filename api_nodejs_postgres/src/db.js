import pg from "pg";

const pool = new pg.Pool({
  user: "root",
  host: "localhost",
  password: "abc123",
  database: "bd_Products",
  port: "5432"
});

pool.on("connect", () => {
  console.log("Connected to the PostgreSQL database");
});

export default pool;
