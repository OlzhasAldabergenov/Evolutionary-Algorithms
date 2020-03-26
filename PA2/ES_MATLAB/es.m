function [xp, fp, stat] = es(fitnessfct, n, lb, ub, stopeval)
% [xp, fp, stat] = es(fitnessfct, n, lb, ub, stopeval)
  % Strategy parameters
  binsize = 20; % the size of bin used to calculate success rate
  k = 0.82; 

  % Initialize
  xp = rand(1, n) .* (ub - lb) + lb;
  fp = fitnessfct(xp);
  sigma = 0.25 * max(ub - lb);
  evalcount = 0;
  n_success = 0; % the number of successful mutation within a bin

  % Statistics administration
  stat.name = '(1+1)-ES';
  stat.evalcount = 0;
  stat.histsigma = zeros(1, stopeval);
  stat.histf = zeros(1, stopeval);

  % Evolution cycle
  while evalcount < stopeval

    % Generate offspring and evaluate
    xo = xp + sigma * randn(1, n); % generate offspring from parent xp 
    fo = fitnessfct(xo); % evaluate xo using fitnessfct
    evalcount = evalcount + 1;

    % select best
    % Important: MINIMIZATION!
    if fo < fp
        xp = xo;
        fp = fo;
        n_success = n_success + 1;
    end
    
    % update success-rate and update stepsize
    if mod(evalcount, binsize) == 0
        if n_success > 0.2 * binsize
            sigma = sigma / k;
        elseif n_success < 0.2 * binsize
            sigma = sigma * k;
        end
        n_success = 0;
    end

    % Statistics administration
    stat.histsigma(evalcount) = sigma; % stepsize history
    stat.histf(evalcount) = fo; % fitness history

    % if desired: plot the statistics
    clf
    subplot(2, 1, 1)
    semilogy(1:evalcount, stat.histf(1:evalcount), 'k-')
    title('fitness')
    xlabel('evalcount')
    
    subplot(2, 1, 2)
    semilogy(1:evalcount, stat.histsigma(1:evalcount), 'r--')
    title('sigma')
    xlabel('evalcount')
    drawnow()
  end

end

