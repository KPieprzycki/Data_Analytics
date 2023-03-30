functions {
    //Diff between one-sided Gaussian tail probability and target probabilty
    vector tail_delta(vector y, vector theta, real[] x_r, int[] x_i) {
        vector[1] deltas;
        deltas[1] = 2 *  (normal_cdf(theta[1], 0, exp(y[1]))-0.5)-0.99;
        return deltas;
    }
}

data {
    vector[1] y_guess; // Initial guess of Gaussian standard deviation
    vector[1] theta; // Target quantile
}

transformed data {
   vector[1] y;
   real x_r[0];
   int x_i[0];
   

   //FInd Gaussian standard deviation that enures 99 prob. below 15
   y= algebra_solver(tail_delta,y_guess, theta, x_r, x_i);

   print("Standard deiation = ", exp(y[1]));

}

generated quantities {
   real sigma = exp(y[1]);
}