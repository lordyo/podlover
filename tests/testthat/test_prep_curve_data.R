context("Preparing curve data")

library(podlover)

t_exmpl <- t_exmpl

# simple totals
t_prep_11 <- podlove_prepare_stats_for_graph(df_stats = t_exmpl, 
																					hourly = FALSE, 
																					relative = TRUE)

t_prep_12 <- podlove_prepare_stats_for_graph(df_stats = t_exmpl, 
																					hourly = FALSE, 
																					relative = FALSE)

t_prep_13 <- podlove_prepare_stats_for_graph(df_stats = t_exmpl, 
																					hourly = TRUE, 
																					relative = TRUE)

t_prep_14 <- podlove_prepare_stats_for_graph(df_stats = t_exmpl, 
																					hourly = TRUE, 
																					relative = FALSE)

# gvar = episode related
t_prep_21 <- podlove_prepare_stats_for_graph(df_stats = t_exmpl,
																						 gvar = title, 
																					hourly = FALSE, 
																					relative = TRUE)

t_prep_22 <- podlove_prepare_stats_for_graph(df_stats = t_exmpl,
																						 gvar = title, 
																					hourly = FALSE, 
																					relative = FALSE)

t_prep_23 <- podlove_prepare_stats_for_graph(df_stats = t_exmpl, 
																						 gvar = title, 
																					hourly = TRUE, 
																					relative = TRUE)

t_prep_24 <- podlove_prepare_stats_for_graph(df_stats = t_exmpl, 
																						 gvar = title, 
																					hourly = TRUE, 
																					relative = FALSE)

# gvar = other variable
t_prep_31 <- podlove_prepare_stats_for_graph(df_stats = t_exmpl,
																						 gvar = context, 
																					hourly = FALSE, 
																					relative = TRUE)

t_prep_32 <- podlove_prepare_stats_for_graph(df_stats = t_exmpl,
																						 gvar = context, 
																					hourly = FALSE, 
																					relative = FALSE)

t_prep_33 <- podlove_prepare_stats_for_graph(df_stats = t_exmpl, 
																						 gvar = context, 
																					hourly = TRUE, 
																					relative = TRUE)

t_prep_34 <- podlove_prepare_stats_for_graph(df_stats = t_exmpl, 
																						 gvar = context, 
																					hourly = TRUE, 
																					relative = FALSE)

#### no gvar ###

test_that("prep data without gvar have correct dimensions", {
	
	expect_equal(ncol(t_prep_11), 3)
	expect_equal(ncol(t_prep_12), 3)
	expect_equal(ncol(t_prep_13), 3)
	expect_equal(ncol(t_prep_14), 3)
	
	expect_equal(nrow(t_prep_11), 310)
	expect_equal(nrow(t_prep_12), 355)
	expect_equal(nrow(t_prep_13), 1525)
	expect_equal(nrow(t_prep_14), 1987)
	
})

test_that("prep data without gvar have correct colnames", {
	
	cnam <- function(df, i) {
		nams <- colnames(df)
		
		nams[i]
	} 
	
	expect_equal(cnam(t_prep_11, 1), "time")
	expect_equal(cnam(t_prep_11, 2), "listeners")
	expect_equal(cnam(t_prep_11, 3), "listeners_total")
	
	expect_equal(cnam(t_prep_12, 1), "time")
	expect_equal(cnam(t_prep_12, 2), "listeners")
	expect_equal(cnam(t_prep_12, 3), "listeners_total")
	
	expect_equal(cnam(t_prep_13, 1), "time")
	expect_equal(cnam(t_prep_13, 2), "listeners")
	expect_equal(cnam(t_prep_13, 3), "listeners_total")
	
	expect_equal(cnam(t_prep_14, 1), "time")
	expect_equal(cnam(t_prep_14, 2), "listeners")
	expect_equal(cnam(t_prep_14, 3), "listeners_total")
	
})

test_that("prep data without gvar have col classes", {
	
	expect_is(t_prep_11$time, "numeric")
	expect_is(t_prep_11$listeners, "integer")
	expect_is(t_prep_11$listeners_total, "integer")
	
	expect_is(t_prep_12$time, "Date")
	expect_is(t_prep_12$listeners, "integer")
	expect_is(t_prep_12$listeners_total, "integer")
	
	expect_is(t_prep_13$time, "numeric")
	expect_is(t_prep_13$listeners, "integer")
	expect_is(t_prep_13$listeners_total, "integer")
	
	expect_is(t_prep_14$time, "POSIXct")
	expect_is(t_prep_14$listeners, "integer")
	expect_is(t_prep_14$listeners_total, "integer")
	
})

#### gvar = title ####

test_that("prep data with gvar=title have correct dimensions", {
	
	expect_equal(ncol(t_prep_21), 4)
	expect_equal(ncol(t_prep_22), 4)
	expect_equal(ncol(t_prep_23), 4)
	expect_equal(ncol(t_prep_24), 4)
	
	expect_equal(nrow(t_prep_21), 816)
	expect_equal(nrow(t_prep_22), 823)
	expect_equal(nrow(t_prep_23), 2173)
	expect_equal(nrow(t_prep_24), 2172)
	
})

test_that("prep data with gvar=title have correct colnames", {
	
	cnam <- function(df, i) {
		nams <- colnames(df)
		
		nams[i]
	} 
	
	expect_equal(cnam(t_prep_21, 1), "time")
	expect_equal(cnam(t_prep_21, 2), "title")
	expect_equal(cnam(t_prep_21, 3), "listeners")
	expect_equal(cnam(t_prep_21, 4), "listeners_total")
	
	expect_equal(cnam(t_prep_22, 1), "time")
	expect_equal(cnam(t_prep_22, 2), "title")
	expect_equal(cnam(t_prep_22, 3), "listeners")
	expect_equal(cnam(t_prep_22, 4), "listeners_total")
	
	expect_equal(cnam(t_prep_23, 1), "time")
	expect_equal(cnam(t_prep_23, 2), "title")
	expect_equal(cnam(t_prep_23, 3), "listeners")
	expect_equal(cnam(t_prep_23, 4), "listeners_total")
	
	expect_equal(cnam(t_prep_24, 1), "time")
	expect_equal(cnam(t_prep_24, 2), "title")
	expect_equal(cnam(t_prep_24, 3), "listeners")
	expect_equal(cnam(t_prep_24, 4), "listeners_total")
	
})

#### gvar = context ####

test_that("prep data with gvar=title have correct dimensions", {
	
	expect_equal(ncol(t_prep_31), 4)
	expect_equal(ncol(t_prep_32), 4)
	expect_equal(ncol(t_prep_33), 4)
	expect_equal(ncol(t_prep_34), 4)
	
	expect_equal(nrow(t_prep_31), 687)
	expect_equal(nrow(t_prep_32), 830)
	expect_equal(nrow(t_prep_33), 1901)
	expect_equal(nrow(t_prep_34), 2574)
	
})

test_that("prep data with gvar=title have correct colnames", {
	
	cnam <- function(df, i) {
		nams <- colnames(df)
		
		nams[i]
	} 
	
	expect_equal(cnam(t_prep_31, 1), "time")
	expect_equal(cnam(t_prep_31, 2), "context")
	expect_equal(cnam(t_prep_31, 3), "listeners")
	expect_equal(cnam(t_prep_31, 4), "listeners_total")
	
	expect_equal(cnam(t_prep_32, 1), "time")
	expect_equal(cnam(t_prep_32, 2), "context")
	expect_equal(cnam(t_prep_32, 3), "listeners")
	expect_equal(cnam(t_prep_32, 4), "listeners_total")
	
	expect_equal(cnam(t_prep_33, 1), "time")
	expect_equal(cnam(t_prep_33, 2), "context")
	expect_equal(cnam(t_prep_33, 3), "listeners")
	expect_equal(cnam(t_prep_33, 4), "listeners_total")
	
	expect_equal(cnam(t_prep_34, 1), "time")
	expect_equal(cnam(t_prep_34, 2), "context")
	expect_equal(cnam(t_prep_34, 3), "listeners")
	expect_equal(cnam(t_prep_34, 4), "listeners_total")
	
})

## cleanup

rm(t_exmpl)
rm(list = ls(pattern = "^t_prep"))