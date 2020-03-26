function [xp, fp, stat] = es(fitnessfct, n, lb, ub, stopeval)
% [xp, fp, stat] = es(fitnessfct, n, lb, ub, stopeval)
  % Strategy parameters
  ...

  % Initialize
  xp = ...
  fp = ...
  sigma = ...
  evalcount = 0;

  % Statistics administration
  stat.name = '(1+1)-ES';
  stat.evalcount = 0;
  stat.histsigma = zeros(1, stopeval);
  stat.histf = zeros(1, stopeval);

  % Evolution cycle
  while evalcount < stopeval

    % Generate offspring and evaluate
    xo = ... % generate offspring from parent xp 
    fo = ... % evaluate xo using fitnessfct
    evalcount = evalcount + 1;

    % select best and update success-rate and update stepsize
    % Important: MINIMIZATION!

    % Statistics administration
    stat.histsigma = % stepsize history
    stat.histf = % fitness history

    % if desired: plot the statistics

  end

end

