library(dplyr)
library(DBI)
library(RPostgres)
library(paws.storage)

# docker_con <- dbConnect(
#   RPostgres::Postgres(),
#   dbname = "postgres",
#   host = "postgres",
#   port = 5432,
#   user = "postgres",
#   password = "zikora"
# )

s3 <- s3()

obj <- s3$get_object(
  Bucket = "kelechi-data-engineering-practice-2026",
  Key = "raw/customers.csv"
)

customers <- read_csv(I(rawToChar(obj$Body)))

print(customers)

docker_con <- dbConnect(
  RPostgres::Postgres(),
  dbname = "postgres",
  host = Sys.getenv("DB_HOST"),
  port = 5432,
  user = Sys.getenv("DB_USER"),
  password = Sys.getenv("DB_PASSWORD")
)

dbWriteTable(
  docker_con,
  "customers",
  customers,
  overwrite = TRUE
)

print(dbGetQuery(
  docker_con,
  "SELECT * FROM customers"
))

dbDisconnect(docker_con)
