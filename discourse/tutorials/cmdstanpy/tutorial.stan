functions {
    vector f(real t, vector y, real R, real K) {
        vector[1] dy_dt;

        dy_dt[1] = y[1]*R*(1 - y[1]/K);

        return dy_dt;
    }
}

data {
    int<lower=0> N;  // Number of data points
    int<lower=0> T;  // Number of time points
    vector[N] y;  // Input data
    array[T] real t;  // Time points
    array[N] int<lower=1, upper=T> t_idx;  // Time index for each data point
    int<lower=0, upper=1> include_likelihood;
}

parameters {
    real<lower=0> y0;  // Initial condition
    real<lower=0> R;  // Growth rate
    real<lower=0> K;  // Carrying capacity
    real<lower=0> S;  // Noise scale
}

transformed parameters {
    array[T] vector[1] z;

    z[1, 1] = y0;
    z[2:T, 1] = ode_rk45(f, z[1,], t[1], t[2:T], R, K)[,1];
}

model {
    y0 ~ std_normal();
    R ~ std_normal();
    K ~ normal(10, 1);
    S ~ std_normal();

    if (include_likelihood)
        y ~ normal(z[t_idx, 1], S);
}

generated quantities {
    array[N] real y_rep = normal_rng(z[t_idx, 1], S);  // Posterior predictive
    array[N] real z_rep = z[t_idx, 1];  // Posterior samples of ODE solution
}
