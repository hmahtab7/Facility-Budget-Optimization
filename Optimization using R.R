# Load the necessary package
library(lpSolve)

# Define the objective function coefficients (People reached per dollar)
obj.func.coeffs <- c(10, 6, 8, 5)  # Corresponding to SM, TV, Email, Print

# Define the constraint coefficients matrix (LHS)
constraint.coeffs <- matrix(c(
  1, 1, 1, 1,   # Total Marketing Budget Constraint (≤ 100,000)
  -0.2, 0.8, -0.2, -0.2,   # TV Budget Min Constraint (>20% of total budget)
  -0.3, -0.3, -0.3, 0.7,   # Print Budget Max Constraint (≤ 30% of total budget)
  0.5, 0, 1, 0,   # Email Budget Constraint (Email ≥ 0.5 * Social Media) 
  10, -6, -8, -5,  # Social Media Reach 
  -10, 6, -8, -5,  # TV Reach 
  -10, -6, 8, -5,  # Email Reach 
  -10, -6, -8, 5,  # Print Reach 
  1, 0, 0, 0,   # Social Media Budget Min Constraint
  0, 1, 0, 0,   # TV Budget Min Constraint
  0, 0, 1, 0,   # Email Budget Min Constraint
  0, 0, 0, 1    # Print Budget Min Constraint
), nrow = 12, byrow = TRUE)

# Define the constraint directions
constraint.dir <- c("<=", ">=", "<=", ">=", "<=", "<=", "<=", "<=", ">=", ">=", ">=", ">=")

# Define the constraint RHS values
constraint.rhs <- c(
  100000,   # Total Marketing Budget 
  0,        # TV Budget Minimum 
  0,        # Print Budget Maximum 
  0,        # Email Budget Constraint 
  0,        # SM Reach Diversification
  0,        # TV Reach Diversification
  0,        # Email Reach Diversification
  0,        # Print Reach Diversification
  15000,    # Minimum Social Media Budget
  15000,    # Minimum TV Budget
  15000,    # Minimum Email Budget
  15000     # Minimum Print Budget
)

# Solve the LP
lp1.solution <- lp(direction = "max", obj.func.coeffs, constraint.coeffs,
                   constraint.dir, constraint.rhs)

# Print the optimal objective function value and DV values in the console
lp1.solution$objval
lp1.solution$solution

# Store the optimal DV values as a named object (for future use)
dv.values <- lp1.solution$solution


# Solve the LP with sensitivity
lp1.solution <- lp(direction = "max", obj.func.coeffs, constraint.coeffs,
                   constraint.dir, constraint.rhs, compute.sens = TRUE)
lp1.solution$sens.coef.from
lp1.solution$sens.coef.to
lp1.solution$duals
lp1.solution$duals.from
lp1.solution$duals.to
