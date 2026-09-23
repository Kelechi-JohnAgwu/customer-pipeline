library(testthat)

source(testthat::test_path("..", "..", "R", "functions.R"))

test_that("customer file is read correctly", {
  
  test_file <- tempfile(fileext = ".csv")
  
  writeLines(
    c(
      "customer_id,customer_name,city",
      "C001,Kelechi,Glasgow",
      "C002,Funmi,Edinburgh"
    ),
    test_file
  )
  
  customers <- read_customers(test_file)
  
  expect_equal(nrow(customers), 2)
  expect_equal(ncol(customers), 3)
})


