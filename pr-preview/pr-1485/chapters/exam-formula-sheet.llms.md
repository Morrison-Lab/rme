# Exam Formula Sheet

Code

Published

Last modified: 2026-11-11: 21:33:10 (UTC)

# 1 Epi 202: Probability

$$\begin{aligned}
{\operatorname{Var}\mathopen{}\left(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{a}}\vphantom{a}}\cdot \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{X}}\vphantom{X}}\right)\mathclose{}}
&= {\operatorname{Var}\mathopen{}\left(\sum_{i=1}^na_i X_i\right)\mathclose{}}
\\ &= \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{a}}\vphantom{a}}^{\top} {\operatorname{Var}\mathopen{}\left(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{X}}\vphantom{X}}\right)\mathclose{}} \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{a}}\vphantom{a}}
\\ &= \sum_{i=1}^n\sum_{j=1}^n a_i a_j {\operatorname{Cov}\mathopen{}\left(X_i,X_j\right)\mathclose{}}
\end{aligned}$$

$${\mathbb{E}\mathopen{}\left[Y\right]\mathclose{}} = {\mathbb{E}\mathopen{}\left[{\mathbb{E}\mathopen{}\left[Y \mid X\right]\mathclose{}}\right]\mathclose{}}$$

$${\mathbb{E}\mathopen{}\left[Y \mid Z\right]\mathclose{}} = {\mathbb{E}\mathopen{}\left[{\mathbb{E}\mathopen{}\left[Y \mid X,Z\right]\mathclose{}} \mid Z\right]\mathclose{}}$$

$${\operatorname{Var}\mathopen{}\left(Y\right)\mathclose{}} = {\mathbb{E}\mathopen{}\left[{\operatorname{Var}\mathopen{}\left(Y \mid X\right)\mathclose{}}\right]\mathclose{}} + {\operatorname{Var}\mathopen{}\left({\mathbb{E}\mathopen{}\left[Y \mid X\right]\mathclose{}}\right)\mathclose{}}$$

$${\operatorname{Cov}\mathopen{}\left(Y,Z\right)\mathclose{}} = {\mathbb{E}\mathopen{}\left[{\operatorname{Cov}\mathopen{}\left(Y,Z \mid X\right)\mathclose{}}\right]\mathclose{}} + {\operatorname{Cov}\mathopen{}\left({\mathbb{E}\mathopen{}\left[Y \mid X\right]\mathclose{}}, {\mathbb{E}\mathopen{}\left[Z \mid X\right]\mathclose{}}\right)\mathclose{}}$$

# 2 Epi 203: Statistical inference

$$\mathcal{L}(\theta) \stackrel{\text{def}}{=}\operatorname{p}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{X}}\vphantom{X}}= \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}| \Theta = \theta)$$

$$\ell\stackrel{\text{def}}{=}{\operatorname{log}\mathopen{}\left\{\mathcal{L}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}|\theta)\right\}\mathclose{}}$$

$$\ell'\stackrel{\text{def}}{=}\frac{\partial}{\partial \theta} \ell(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}|\theta)$$

$$\ell''\stackrel{\text{def}}{=}\frac{\partial}{\partial \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\theta}}\vphantom{\theta}}}\frac{\partial}{\partial \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\theta}}\vphantom{\theta}}^{\top}} \ell(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}| \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\theta}}\vphantom{\theta}})$$

$$\ell_{ij}''=
\frac{\partial}{\partial \theta_i}\frac{\partial}{\partial \theta_j} \ell(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{X}}\vphantom{X}}= \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}| \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\theta}}\vphantom{\theta}})$$

$$I\stackrel{\text{def}}{=}-\ell''(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\theta}}\vphantom{\theta}})$$ $$\mathcal{I}\stackrel{\text{def}}{=}{\mathbb{E}\mathopen{}\left[I(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}|\theta)\right]\mathclose{}}$$

$$\hat\theta_{ML}\ \dot \sim\ {\operatorname{N}\mathopen{}\left(\theta,{\mathopen{}\left[\mathcal{I}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\theta}}\vphantom{\theta}})\right]\mathclose{}}^{-1}\right)\mathclose{}}$$

For one parameter $\theta_k$:

$$\text{CI}_{1-\alpha}(\theta_k)
=
\mathopen{}\left[
\hat{\theta}_k
\pm
z_{1 - \frac{\alpha}{2}}
{\mathop{\widehat{\operatorname{SE}}}\nolimits\mathopen{}\left(\hat{\theta}_k\right)\mathclose{}}
\right]\mathclose{}$$

$$Z_k
\stackrel{\text{def}}{=}
\frac{\hat{\theta}_k-\theta_{k,0}}{{\mathop{\widehat{\operatorname{SE}}}\nolimits\mathopen{}\left(\hat{\theta}_k\right)\mathclose{}}}
\ \dot{\sim} \
{\operatorname{N}\mathopen{}\left(0,1\right)\mathclose{}}
\qquad
\text{under }H_0:\theta_k=\theta_{k,0}
\qquad
z_k\text{ = observed }Z_k$$

$$\begin{aligned}
p\text{-value}
&= 2\Pr \mathopen{}\left(\mathopen{}\left|Z\right|\mathclose{}\ge \mathopen{}\left|z_k\right|\mathclose{}\right)\mathclose{},\quad Z\sim {\operatorname{N}\mathopen{}\left(0,1\right)\mathclose{}}
\\
&= 2\mathopen{}\left(1-\Phi\mathopen{}\left(\mathopen{}\left|z_k\right|\mathclose{}\right)\mathclose{}\right)\mathclose{}
\end{aligned}$$

# 3 Sta 108: Linear regression

$$t_k
\stackrel{\text{def}}{=}
\frac{\hat{\beta}_k-\beta_{k,0}}{{\mathop{\widehat{\operatorname{SE}}}\nolimits\mathopen{}\left(\hat{\beta}_k\right)\mathclose{}}}
\ \dot{\sim} \
t_{n-p}
\qquad
\text{under }H_0:\beta_k=\beta_{k,0}
\qquad
t_k^{\text{obs}}\text{ = observed }t_k$$

$$\text{CI}_{1-\alpha}(\beta_k)
=
\mathopen{}\left[
\hat{\beta}_k
\pm
t_{n-p}\mathopen{}\left(1-\frac{\alpha}{2}\right)\mathclose{}
{\mathop{\widehat{\operatorname{SE}}}\nolimits\mathopen{}\left(\hat{\beta}_k\right)\mathclose{}}
\right]\mathclose{}$$

Let $T_{n-p}\sim t_{n-p}$.

$$\begin{aligned}
p\text{-value}
&=
2\Pr \mathopen{}\left(\mathopen{}\left|T_{n-p}\right|\mathclose{}\ge \mathopen{}\left|t_k^{\text{obs}}\right|\mathclose{}\right)\mathclose{}
\\
&=
2\mathopen{}\left(1-F_{t_{n-p}}\mathopen{}\left(\mathopen{}\left|t_k^{\text{obs}}\right|\mathclose{}\right)\mathclose{}\right)\mathclose{}
\end{aligned}$$

$$\text{CI}_{1-\alpha}\mathopen{}\left(\mu\mathopen{}\left(\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}\right)\mathclose{}\right)\mathclose{}
=
\mathopen{}\left[
\hat{\mu}\mathopen{}\left(\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}\right)\mathclose{}
\pm
t_{n-p}\mathopen{}\left(1-\frac{\alpha}{2}\right)\mathclose{}
{\mathop{\widehat{\operatorname{SE}}}\nolimits\mathopen{}\left(\hat{\mu}\mathopen{}\left(\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}\right)\mathclose{}\right)\mathclose{}}
\right]\mathclose{}$$

$Y^*$ denotes a new observation (not in the training data), with corresponding covariate pattern $\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}$. Let $\hat{Y}^* \stackrel{\text{def}}{=}\hat{\mu}\mathopen{}\left(\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}\right)\mathclose{}$.

$$\text{PI}_{1-\alpha}\mathopen{}\left(Y^*|\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}\right)\mathclose{}
=
\mathopen{}\left[
\hat{Y}^*
\pm
t_{n-p}\mathopen{}\left(1-\frac{\alpha}{2}\right)\mathclose{}
{\mathop{\widehat{\operatorname{SE}}}\nolimits\mathopen{}\left(Y^*-\hat{Y}^*\right)\mathclose{}}
\right]\mathclose{}$$

$${\mathop{\widehat{\operatorname{SE}}}\nolimits\mathopen{}\left(Y^*-\hat{Y}^*\right)\mathclose{}}
=
\hat{\sigma}\sqrt{1 + {(\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}})}^{\top}(\mathbf{X}'\mathbf{X})^{-1}\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}}$$

$${\operatorname{Var}\mathopen{}\left(Y^* - \hat{Y}^*\right)\mathclose{}}
= \sigma^2\mathopen{}\left(1 + {(\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}})}^{\top}(\mathbf{X}'\mathbf{X})^{-1}\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}\right)\mathclose{}$$

Let $\hat{\Sigma} \stackrel{\text{def}}{=}{\mathop{\widehat{\operatorname{Var}}}\nolimits\mathopen{}\left(\hat{\beta}\right)\mathclose{}} = \hat{\sigma}^2(\mathbf{X}'\mathbf{X})^{-1}$.

$${\mathop{\widehat{\operatorname{Var}}}\nolimits\mathopen{}\left(\hat{\mu}\mathopen{}\left(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}\right)\mathclose{}\right)\mathclose{}} = {\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}}^{\top}\hat{\Sigma}\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}$$

Let $\Delta\mu\mathopen{}\left(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}, \mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}\right)\mathclose{} = \mu\mathopen{}\left(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}\right)\mathclose{} - \mu\mathopen{}\left(\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}\right)\mathclose{}$, and let $\Delta\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}= \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}- \mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}$; then:

$${\mathop{\widehat{\operatorname{Var}}}\nolimits\mathopen{}\left(\widehat{\Delta\mu}\mathopen{}\left(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}, \mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}\right)\mathclose{}\right)\mathclose{}} = {\Delta\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}}^{\top}\hat{\Sigma}\Delta\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}$$

# 4 Epi 204: Generalized linear models

Generalized linear models have three components:

1.  The **outcome distribution** family: $\operatorname{p}(Y|\mu(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}))$

2.  The **link function**: $g(\mu(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})) = \eta(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})$

3.  The **linear component**: $\eta(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) = \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}\cdot \beta$

$$\text{ϙ}_{\omega}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}},\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}) = {\operatorname{exp}\mathopen{}\left\{(\Delta\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) \cdot \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}\right\}\mathclose{}}$$

## 4.1 Estimates of odds ratios from 2x2 contingency tables

$$\hat{\theta}=\frac{ad}{bc}$$

## Summary of logistic regression definitions and results

## Odds and log-odds

These association-measure results are covered in [Measures of Association for Binary Outcomes](../chapters/binary-outcome-associations.llms.md).

**Odds** ([def](../chapters/binary-outcome-associations.llms.md#def-odds)) $$\omega\stackrel{\text{def}}{=}\frac{\Pr(A)}{\Pr(\neg A)}$$

**Conditional odds** ([def](../chapters/binary-outcome-associations.llms.md#def-c-odds)) $$\omega(A|B) \stackrel{\text{def}}{=}\frac{\Pr(A|B)}{\Pr(\neg A|B)}$$

**Odds function** ([def](../chapters/binary-outcome-associations.llms.md#def-odds-fn)) $${\operatorname{odds}\mathopen{}\left\{\pi\right\}\mathclose{}} \stackrel{\text{def}}{=}\frac{\pi}{1-\pi}$$

**Probability to odds** ([thm](../chapters/binary-outcome-associations.llms.md#thm-prob-to-odds), [cor](../chapters/binary-outcome-associations.llms.md#cor-oddsf-to-odds)) $$\omega= \frac{\pi}{1-\pi} = {\operatorname{odds}\mathopen{}\left\{\pi\right\}\mathclose{}}$$

**Simplified odds expressions; odds of a non-event** ([thm](../chapters/binary-outcome-associations.llms.md#thm-odds-simplified), [cor](../chapters/binary-outcome-associations.llms.md#cor-odds-neg)) $${\operatorname{odds}\mathopen{}\left\{\pi\right\}\mathclose{}} = \frac{1}{\pi^{-1}-1} = {\mathopen{}\left(\pi^{-1}-1\right)\mathclose{}}^{-1},
\qquad \omega(\neg A) = \frac{1-\pi}{\pi} = \pi^{-1}-1$$

**Odds ratio** ([def](../chapters/binary-outcome-associations.llms.md#def-OR)) $$\text{ϙ}(\omega_1, \omega_2) \stackrel{\text{def}}{=}\frac{\omega_1}{\omega_2}$$

**OR as ratio of probability ratios** ([thm](../chapters/binary-outcome-associations.llms.md#thm-or-ratio-ratio)) $$\text{ϙ}(\omega_1, \omega_2)
= \frac{\omega_1}{\omega_2}
= \frac{\mathopen{}\left(\frac{\pi_1}{1-\pi_1}\right)\mathclose{}}{\mathopen{}\left(\frac{\pi_2}{1-\pi_2}\right)\mathclose{}}$$

**Odds ratios are reversible, marginally and conditionally** ([thm](../chapters/binary-outcome-associations.llms.md#thm-or-swap), [thm](../chapters/binary-outcome-associations.llms.md#thm-conditional-OR-swap)) $$\text{ϙ}_{\omega}(A|B) = \text{ϙ}_{\omega}(B|A),
\qquad \text{ϙ}_{\omega}(A|B,C) = \text{ϙ}_{\omega}(B|A,C)$$

## Inverse-odds and probability recovery

**Odds to probability** ([thm](../chapters/binary-outcome-associations.llms.md#thm-odds-to-prob)) $$\pi = \frac{\omega}{1+\omega}$$

**Inverse-odds function** ([def](../chapters/binary-outcome-associations.llms.md#def-inv-odds); recovers probability by [cor](../chapters/binary-outcome-associations.llms.md#cor-invodds-pi)) $${\operatorname{invodds}\mathopen{}\left\{\omega\right\}\mathclose{}} \stackrel{\text{def}}{=}\frac{\omega}{1 + \omega},
\qquad \pi= {\operatorname{invodds}\mathopen{}\left\{\omega\right\}\mathclose{}}$$

**Simplified inverse-odds** ([lem](../chapters/binary-outcome-associations.llms.md#lem-invodds-simplified)) $${\operatorname{invodds}\mathopen{}\left\{\omega\right\}\mathclose{}} = \frac{1}{1+\omega^{-1}} = (1+\omega^{-1})^{-1}$$

**One minus inverse-odds, and its complement** ([lem](../chapters/binary-outcome-associations.llms.md#lem-one-minus-odds-inv), [cor](../chapters/binary-outcome-associations.llms.md#cor-inverse-odds-nonevent)) $$1 - \pi= \frac{1}{1+\omega},
\qquad 1+\omega= \frac{1}{1-\pi}$$

## Log-odds (logit) and expit

**Log-odds, and log-odds from probability** ([def](../chapters/binary-outcome-associations.llms.md#def-logodds), [thm](../chapters/binary-outcome-associations.llms.md#thm-logodds-pi)) $$\eta\stackrel{\text{def}}{=}{\operatorname{log}\mathopen{}\left\{\omega\right\}\mathclose{}},
\qquad \eta= {\operatorname{log}\mathopen{}\left\{\frac{\pi}{1-\pi}\right\}\mathclose{}}$$

**Logit function, and expanded form** ([def](../chapters/binary-outcome-associations.llms.md#def-logit-fn), [thm](../chapters/binary-outcome-associations.llms.md#thm-logit-function)) $$\operatorname{logit}(\pi) \stackrel{\text{def}}{=}{\operatorname{log}\mathopen{}\left\{{\operatorname{odds}\mathopen{}\left\{\pi\right\}\mathclose{}}\right\}\mathclose{}} = {\operatorname{log}\mathopen{}\left\{\frac{\pi}{1-\pi}\right\}\mathclose{}}$$

**Log-odds equals logit** ([cor](../chapters/binary-outcome-associations.llms.md#cor-logodds-logit)) $$\eta= {\operatorname{logit}\mathopen{}\left\{\pi\right\}\mathclose{}}$$

**Odds and probability from log-odds** ([lem](../chapters/binary-outcome-associations.llms.md#lem-odds-from-logodds), [thm](../chapters/binary-outcome-associations.llms.md#thm-prob-from-logodds)) $$\omega= {\operatorname{exp}\mathopen{}\left\{\eta\right\}\mathclose{}},
\qquad \pi= \frac{{\operatorname{exp}\mathopen{}\left\{\eta\right\}\mathclose{}}}{1+{\operatorname{exp}\mathopen{}\left\{\eta\right\}\mathclose{}}}$$

**Expit / inverse-logit function, and equivalent expressions** ([def](../chapters/binary-outcome-associations.llms.md#def-expit), [thm](../chapters/binary-outcome-associations.llms.md#thm-expit-expressions)) $$\operatorname{expit}(\eta) \stackrel{\text{def}}{=}{\operatorname{invodds}\mathopen{}\left\{{\operatorname{exp}\mathopen{}\left\{\eta\right\}\mathclose{}}\right\}\mathclose{}}
= \frac{{\operatorname{exp}\mathopen{}\left\{\eta\right\}\mathclose{}}}{1+{\operatorname{exp}\mathopen{}\left\{\eta\right\}\mathclose{}}} = (1 + {\operatorname{exp}\mathopen{}\left\{-\eta\right\}\mathclose{}})^{-1}$$

**Probability as expit** ([thm](../chapters/binary-outcome-associations.llms.md#thm-expit-prob-logodds)) $$\pi= {\operatorname{expit}\mathopen{}\left\{\eta\right\}\mathclose{}} \tag{1}$$

**Logit and expit are inverses** ([thm](../chapters/binary-outcome-associations.llms.md#thm-logit-expit)) $${\operatorname{logit}\mathopen{}\left\{{\operatorname{expit}\mathopen{}\left\{\eta\right\}\mathclose{}}\right\}\mathclose{}} = \eta\qquad {\operatorname{expit}\mathopen{}\left\{{\operatorname{logit}\mathopen{}\left\{\pi\right\}\mathclose{}}\right\}\mathclose{}} = \pi$$

> **NOTE:**
>
> $$\underbrace{\pi}_{{\Pr\mathopen{}\left(Y=1\right)\mathclose{}}}
> \overbrace{
> \underbrace{
> \underset{
> \xleftarrow[\frac{\omega}{1+\omega}]{}
> }
> {
> \xrightarrow{\frac{\pi}{1-\pi}}
> }
> \underbrace{\omega}_{{\operatorname{odds}\mathopen{}\left\{Y=1\right\}\mathclose{}}}
> \underset{
> \xleftarrow[{\operatorname{exp}\mathopen{}\left\{\eta\right\}\mathclose{}}]{}
> }
> {
> \xrightarrow{{\operatorname{log}\mathopen{}\left\{\omega\right\}\mathclose{}}}
> }
> }_{{\operatorname{expit}\mathopen{}\left\{\eta\right\}\mathclose{}}}
> }^{{\operatorname{logit}\mathopen{}\left\{\pi\right\}\mathclose{}}}
> \underbrace{\eta}_{{\eta\mathopen{}\left(Y=1\right)\mathclose{}}}$$
>
> Figure 1: Diagram of [logistic regression](../chapters/logistic-regression.llms.md#def-logistic-regression) link and inverse [link functions](../chapters/Intro-to-GLMs.llms.md#sec-why-link)

## Rare events

**Odds minus probability** ([thm](../chapters/binary-outcome-associations.llms.md#thm-odds-minus-probs)) $$\omega- \pi = \frac{\pi^2}{1-\pi}, \quad \text{where } \omega= \frac{\pi}{1-\pi}$$

**OR as RR times a correction factor** ([thm](../chapters/binary-outcome-associations.llms.md#thm-rare-disease-or-rr)) $$\text{ϙ}(\omega_1, \omega_2)
= \rho(\pi_1, \pi_2) \cdot \frac{1-\pi_2}{1-\pi_1}$$ When $\pi_1$ and $\pi_2$ are both small, the correction factor is close to 1, so the [odds ratio](../chapters/binary-outcome-associations.llms.md#def-OR) is close to the [risk ratio](../chapters/binary-outcome-associations.llms.md#def-RR).

## Derivatives

$$\begin{array}{r|ccccc}
& \pi& \omega& \eta& \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}& \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}\\
\hline
\pi
  & 1
  & {\mathopen{}\left(1+\omega\right)\mathclose{}}^{2}
  & \dfrac{{\mathopen{}\left(1+\omega\right)\mathclose{}}^{2}}{\omega}
  & \text{undef}
  & \text{undef} \\[10pt]
\omega
  & {\mathopen{}\left(1-\pi\right)\mathclose{}}^{2}
  & 1
  & \dfrac{1}{\omega}
  & \text{undef}
  & \text{undef} \\[10pt]
\eta
  & \pi(1-\pi)
  & \omega
  & 1
  & \text{undef}
  & \text{undef} \\[10pt]
\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}
  & \underbrace{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}\pi(1-\pi)}_{p \times 1}
  & \underbrace{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}\omega}_{p \times 1}
  & \underbrace{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}}_{p \times 1}
  & \underbrace{\mathbb{I}}_{p \times p}
  & \mathbf{0}_{p \times p} \\[10pt]
\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}
  & \underbrace{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}\pi(1-\pi)}_{p \times 1}
  & \underbrace{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}\omega}_{p \times 1}
  & \underbrace{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}}_{p \times 1}
  & \mathbf{0}_{p \times p}
  & \underbrace{\mathbb{I}}_{p \times p} \\
\end{array}$$

Column labels indicate the numerators of the [derivatives](https://morrison-lab.github.io/mds/calculus-derivatives.html#def-derivative); row labels indicate the denominators (dimensions and details in [tbl](../chapters/logistic-regression.llms.md#tbl-logistic-deriv-matrix)).

**Derivative of expit** ([cor](../chapters/logistic-regression.llms.md#cor-deriv-expit)) $${\operatorname{expit}'\mathopen{}\left\{\eta\right\}\mathclose{}} = {\operatorname{expit}\mathopen{}\left\{\eta\right\}\mathclose{}}(1 - {\operatorname{expit}\mathopen{}\left\{\eta\right\}\mathclose{}})$$

## Logistic regression model

**Logistic regression** ([def](../chapters/logistic-regression.llms.md#def-logistic-regression)) $$Y_i|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{X}}\vphantom{X}}_i \ \sim_{\perp\!\!\!\perp}\ \operatorname{Ber}(\pi(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{X}}\vphantom{X}}_i)), \qquad {\operatorname{logit}\mathopen{}\left\{\pi(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})\right\}\mathclose{}} = {\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}}^{\top}\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}$$

Throughout this summary, $\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}= (\beta_0, \beta_1, \ldots, \beta_p)$ is the $(p+1) \times 1$ coefficient vector (including the intercept), $\mathbf{X}$ is the $n \times (p+1)$ design matrix whose $i^{\text{th}}$ row is ${\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}_i}^{\top}$, and $\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\varepsilon}}\vphantom{\varepsilon}}$ is the $n \times 1$ error vector with components $\varepsilon_i \stackrel{\text{def}}{=}y_i - \pi_i$.

## Log-likelihood and score function

**Log-likelihood component** ([lem](../chapters/logistic-regression.llms.md#lem-logistic-loglik-component)) $$\ell_i(\pi_i) = y_i \eta_i - {\operatorname{log}\mathopen{}\left\{1+\omega_i\right\}\mathclose{}}$$

**Score function as sum of components** ([lem](../chapters/logistic-regression.llms.md#lem-score-logistic), [thm](../chapters/logistic-regression.llms.md#thm-logistic-score-comp)) $$\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\ell'}}\vphantom{\ell'}}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}) = \sum_{i=1}^n\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\ell'_i}}\vphantom{\ell'_i}}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}),
\qquad \ell_i'(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}) = \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}_i \varepsilon_i$$

**[Score function](https://morrison-lab.github.io/sds/intro-MLEs.html#def-score)** ([thm](../chapters/logistic-regression.llms.md#thm-logistic-score-fn)) $$\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\ell'}}\vphantom{\ell'}}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}) = \sum_{i=1}^n\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}_i\varepsilon_i
= \underbrace{{\mathbf{X}}^{\top}}_{(p+1) \times n}\underbrace{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\varepsilon}}\vphantom{\varepsilon}}}_{n \times 1}$$

## Maximum likelihood estimation

**Estimating equation** ([eq](../chapters/logistic-regression.llms.md#eq-score-logistic)) The [MLE](https://morrison-lab.github.io/sds/intro-MLEs.html#def-mle) $\hat{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}}$ solves the [score equation](https://morrison-lab.github.io/sds/intro-MLEs.html#def-score-equation): $$\underbrace{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\ell'}}\vphantom{\ell'}}(\hat{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}})}_{(p+1) \times 1} = \sum_{i=1}^n\underbrace{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}_i}_{(p+1) \times 1}\underbrace{\mathopen{}\left(y_i - {\operatorname{expit}\mathopen{}\left\{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}_i}^{\top}\hat{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}}\right\}\mathclose{}}\right)\mathclose{}}_{1 \times 1} = \mathbf{0}_{(p+1) \times 1}$$

This estimating equation has no closed-form solution in general; $\hat{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}}$ must be computed by numerical iteration.

**Hessian** ([eq](../chapters/logistic-regression.llms.md#eq-logistic-hess)) $$\underbrace{\ell''(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}})}_{(p+1) \times (p+1)} = -\underbrace{{\mathbf{X}}^{\top}}_{(p+1) \times n} \underbrace{\mathbf{D}}_{n \times n} \underbrace{\mathbf{X}}_{n \times (p+1)}, \qquad \mathbf{D} \stackrel{\text{def}}{=}\text{diag}({\operatorname{Var}\mathopen{}\left(Y_i|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{X}}\vphantom{X}}_i=\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}_i\right)\mathclose{}}) = \text{diag}(\pi_i(1-\pi_i))$$

**Concavity** ([rem](../chapters/logistic-regression.llms.md#rem-hessian-nsd)): the [Hessian](https://morrison-lab.github.io/mds/vector-calculus.html#def-hessian) is negative semi-definite for every $\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}$ (negative definite when $\mathbf{X}$ has full column rank), so the [log-likelihood](https://morrison-lab.github.io/sds/intro-MLEs.html#def-loglik) is [concave](https://morrison-lab.github.io/mds/optimization.html#def-strictly-convex) and every solution of the score equation is a global maximum.

**Newton-Raphson update** ([Newton-Raphson method](https://morrison-lab.github.io/sds/intro-MLEs.html#sec-newton-raphson)) $$\underbrace{{\widehat{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}}}^*}_{(p+1) \times 1} \leftarrow \underbrace{{\widehat{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}}}^*}_{(p+1) \times 1} - \underbrace{{\mathopen{}\left({\ell''\mathopen{}\left(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{y}}\vphantom{y}}; {\widehat{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}}}^*\right)\mathclose{}}\right)\mathclose{}}^{-1}}_{(p+1) \times (p+1)} \underbrace{{\ell'\mathopen{}\left(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{y}}\vphantom{y}}; {\widehat{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}}}^*\right)\mathclose{}}}_{(p+1) \times 1}$$

**One-sample MLE for odds** ([thm](../chapters/binary-outcome-associations.llms.md#thm-est-odds)) $$\hat{\omega}= \frac{x}{n-x}$$

## Wald tests and confidence intervals for coefficients

**Wald test statistic** for $H_0: \beta_k = \beta_{k,0}$ ([CLT for MLEs](https://morrison-lab.github.io/sds/intro-MLEs.html#thm-dist-mle)) $$z_k = \frac{\hat{\beta}_k - \beta_{k,0}}{{\mathop{\widehat{\operatorname{SE}}}\nolimits\mathopen{}\left(\hat{\beta}_k\right)\mathclose{}}},
\qquad z_k \ \dot{\sim} \ N(0,1) \text{ under } H_0$$

**95% confidence intervals for** $\beta_k$ and $e^{\beta_k}$ ([MLE](https://morrison-lab.github.io/sds/intro-MLEs.html#def-mle) invariance) $$\hat{\beta}_k \pm 1.96 \cdot {\mathop{\widehat{\operatorname{SE}}}\nolimits\mathopen{}\left(\hat{\beta}_k\right)\mathclose{}},
\qquad e^{\beta_k} \in \mathopen{}\left(e^{\hat{\beta}_k - 1.96 \cdot {\mathop{\widehat{\operatorname{SE}}}\nolimits\mathopen{}\left(\hat{\beta}_k\right)\mathclose{}}},\;
  e^{\hat{\beta}_k + 1.96 \cdot {\mathop{\widehat{\operatorname{SE}}}\nolimits\mathopen{}\left(\hat{\beta}_k\right)\mathclose{}}}\right)\mathclose{}$$

For $k \neq 0$, $e^{\beta_k}$ is an [odds ratio](../chapters/binary-outcome-associations.llms.md#def-OR); for $k = 0$, $e^{\beta_0}$ is the baseline [odds](../chapters/binary-outcome-associations.llms.md#def-odds).

## Odds ratios in logistic regression

**General OR formula** ([lem](../chapters/logistic-regression.llms.md#lem-logistic-OR)) $$\text{ϙ}_{\omega}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}},\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}) = {\operatorname{exp}\mathopen{}\left\{\eta(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) - \eta(\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}})\right\}\mathclose{}}$$

**Difference in log-odds; OR in terms of** $\Delta\eta$ ([def](../chapters/logistic-regression.llms.md#def-difflogodds), [cor](../chapters/logistic-regression.llms.md#cor-logistic-OR)) $$\Delta\eta\stackrel{\text{def}}{=}\eta(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) - \eta(\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}),
\qquad \text{ϙ}_{\omega}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}},\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}) = {\operatorname{exp}\mathopen{}\left\{\Delta\eta\right\}\mathclose{}}$$

$\Delta\eta$ from covariates ([lem](../chapters/logistic-regression.llms.md#lem-diff-logodds)) $$\Delta\eta= (\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}- \mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}})\cdot\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}$$

**Difference in covariate patterns;** $\Delta\eta$ from $\Delta\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}$ ([def](../chapters/logistic-regression.llms.md#def-diff-covs), [cor](../chapters/logistic-regression.llms.md#cor-diff-logodds)) $$\Delta\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}\stackrel{\text{def}}{=}\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}- \mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}},
\qquad \Delta\eta= \Delta\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}\cdot \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}$$

**OR in terms of** $\Delta\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}$ ([thm](../chapters/logistic-regression.llms.md#thm-logistic-OR)) $$\text{ϙ}_{\omega}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}},\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}) = {\operatorname{exp}\mathopen{}\left\{(\Delta\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) \cdot \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}\right\}\mathclose{}}$$

**Log OR equals** $\Delta\eta$ ([cor](../chapters/logistic-regression.llms.md#cor-log-or)) $${\operatorname{log}\mathopen{}\left\{\text{ϙ}_{\omega}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}},\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}})\right\}\mathclose{}} = \Delta\eta$$

## Inference for log-odds and odds ratios

**Estimated SE of log-odds** ([thm](../chapters/logistic-regression.llms.md#thm-est-se-logodds)) $${\mathop{\widehat{\operatorname{Var}}}\nolimits\mathopen{}\left(\hat\eta(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})\right)\mathclose{}} = \underbrace{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}}^{\top}}_{1 \times (p+1)}\underbrace{\hat{\Sigma}}_{(p+1) \times (p+1)}\underbrace{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}}_{(p+1) \times 1},
\qquad {\mathop{\widehat{\operatorname{SE}}}\nolimits\mathopen{}\left(\hat\eta(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})\right)\mathclose{}} = \sqrt{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}}^{\top}\hat{\Sigma}\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}}$$

**Estimated SE of** $\Delta\widehat{\eta}$ ([thm](../chapters/logistic-regression.llms.md#thm-est-se-diff-logodds)) $${\mathop{\widehat{\operatorname{Var}}}\nolimits\mathopen{}\left(\Delta{\hat\eta}\right)\mathclose{}} = \underbrace{{\Delta\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}}^{\top}}_{1 \times (p+1)}\underbrace{\hat{\Sigma}}_{(p+1) \times (p+1)}\underbrace{(\Delta\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})}_{(p+1) \times 1},
\qquad {\mathop{\widehat{\operatorname{SE}}}\nolimits\mathopen{}\left(\Delta{\hat\eta}\right)\mathclose{}} = \sqrt{{\Delta\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}}^{\top}\hat{\Sigma}(\Delta\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})}$$

**CI for an odds ratio** ([eq](../chapters/logistic-regression.llms.md#eq-ci-OR-exp); details in [sec](../chapters/logistic-regression.llms.md#sec-or-inference)): exponentiate the endpoints of the CI for $\Delta\eta$: $$\text{ϙ}_{\omega}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}},\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}) \in (e^L, e^R),
\qquad (L, R) = \widehat{\Delta\eta}\mp 1.96 \cdot {\mathop{\widehat{\operatorname{SE}}}\nolimits\mathopen{}\left(\widehat{\Delta\eta}\right)\mathclose{}}$$

## Odds ratios in study designs

**Disease and exposure odds ratios** ([def](../chapters/binary-outcome-associations.llms.md#def-disease-OR), [def](../chapters/binary-outcome-associations.llms.md#def-exposure-OR)) $$\text{ϙ}_{\omega}(D|E) \stackrel{\text{def}}{=}\frac{\omega(D|E)}{\omega(D|\neg E)},
\qquad \text{ϙ}_{\omega}(E|D) \stackrel{\text{def}}{=}\frac{\omega(E|D)}{\omega(E|\neg D)}$$

**Case-control studies** ([section](../chapters/binary-outcome-associations.llms.md#sec-CC-studies)): outcome-stratified sampling breaks estimation of [risks](../chapters/binary-outcome-associations.llms.md#def-risk-epi), [risk ratios](../chapters/binary-outcome-associations.llms.md#def-RR), and the components of the disease odds ratio ([def](../chapters/binary-outcome-associations.llms.md#def-disease-OR)), but the exposure odds ratio ([def](../chapters/binary-outcome-associations.llms.md#def-exposure-OR)) is estimable, and it equals the disease odds ratio by reversibility ([thm](../chapters/binary-outcome-associations.llms.md#thm-or-swap)).

$2 \times 2$ table shortcut ([table](../chapters/binary-outcome-associations.llms.md#tbl-2x2-generic); cell counts $a, b$ = exposed events and non-events, $c, d$ = unexposed events and non-events): $$\hat{\omega}(Event|Exposed) = \frac{a}{b},
\qquad \hat{\omega}(Event|\neg Exposed) = \frac{c}{d},
\qquad \text{ϙ}_{\omega}(Exposed, \neg Exposed) = \frac{ad}{bc}$$

## Model fit and comparison

Details in [sec](../chapters/logistic-regression.llms.md#sec-gof); here $q$ is the number of distinct covariate patterns, $p$ is the number of $\beta$ parameters, and $\ell_{\text{full}}$ is the saturated-model log-likelihood.

**Deviance test** ([def](../chapters/logistic-regression.llms.md#def-deviance-test)) $$D \stackrel{\text{def}}{=}2(\ell_{\text{full}} - \ell(\hat{\beta}; \mathbf x)),
\qquad D \ \dot{\sim} \ \chi^2(q - p)$$

**Hosmer-Lemeshow test** ([def](../chapters/logistic-regression.llms.md#def-hosmer-lemeshow); $g$ groups by predicted probability) $$X^2 \stackrel{\text{def}}{=}\sum_{c=1}^g \frac{(o_c - e_c)^2}{e_c} \ \dot{\sim} \ \chi^2(g-2)$$

**Pearson chi-squared GOF test** (sum of squared Pearson residuals, [def](../chapters/logistic-regression.llms.md#def-pearson-residual)) $$X^2 = \sum_{k=1}^q X_k^2 \ \dot{\sim} \ \chi^2(q-p)$$

**AIC and BIC** \[lower is better\] ([AIC](../chapters/Linear-models-overview.llms.md#def-aic) [\[1\]](#ref-akaike1974new); [BIC](../chapters/Linear-models-overview.llms.md#def-bic) [\[2\]](#ref-schwarz1978estimating)) $$\text{AIC} = -2 \ell(\hat{\theta}) + 2p,
\qquad \text{BIC} = -2 \ell(\hat{\theta}) + p {\operatorname{log}\mathopen{}\left\{n\right\}\mathclose{}}$$

**Likelihood ratio test** ([def](../chapters/logistic-regression.llms.md#def-lrt); for nested models with $p_0 < p_1$ parameters — here $\ell_1$ and $\ell_0$ are the two fitted models’ [log-likelihoods](https://morrison-lab.github.io/sds/intro-MLEs.html#def-loglik), not the [saturated model](../chapters/Linear-models-overview.llms.md#def-saturated-model)’s) $$\Lambda \stackrel{\text{def}}{=}2(\ell_1(\hat{\theta}_1) - \ell_0(\hat{\theta}_0)),
\qquad \Lambda \ \dot{\sim} \ \chi^2(p_1 - p_0) \text{ under } H_0$$ by [Wilks’ theorem](https://morrison-lab.github.io/sds/intro-MLEs.html#thm-wilks).

## Residual-based diagnostics

Residuals are computed per covariate pattern $k$ (grouped data); $h_k$ denotes the leverage of pattern $k$ ([def](../chapters/logistic-regression.llms.md#def-leverage-glm)).

**Response residual** ([def](../chapters/logistic-regression.llms.md#def-response-residual-logistic)) $$e_k \stackrel{\text{def}}{=}\bar y_k - \hat{\pi}(x_k)$$

**Pearson residual (and standardized version)** ([def](../chapters/logistic-regression.llms.md#def-pearson-residual), [def](../chapters/logistic-regression.llms.md#def-standardized-pearson-residual)) $$X_k \stackrel{\text{def}}{=}\frac{\bar y_k - \hat\pi_k}{\sqrt{\hat \pi_k (1-\hat\pi_k)/n_k}},
\qquad r_{P_k} \stackrel{\text{def}}{=}\frac{X_k}{\sqrt{1-h_k}}$$

**Deviance residual (and standardized version)** ([def](../chapters/logistic-regression.llms.md#def-deviance-residual-logistic)) $$d_k \stackrel{\text{def}}{=}\operatorname{sign}(y_k - n_k \hat \pi_k)
{\mathopen{}\left\{\sqrt{2[\ell_{\text{full}}(x_k) - \ell(\hat{\beta}; x_k)]}\right\}\mathclose{}},
\qquad r_{D_k} \stackrel{\text{def}}{=}\frac{d_k}{\sqrt{1-h_k}}$$

**Cook’s distance** ([def](../chapters/logistic-regression.llms.md#def-cooks-distance-glm)) $$D_k \stackrel{\text{def}}{=}\frac{(r_{P_k})^2}{p} \cdot \frac{h_k}{1 - h_k}$$

**Leverage** ([def](../chapters/logistic-regression.llms.md#def-leverage-glm)): $h_k$ is the $k$-th diagonal element of the weighted [hat matrix](../chapters/Linear-models-overview.llms.md#def-hat-matrix) (with $\mathbf{X}$ here the $q \times p$ [design matrix](https://morrison-lab.github.io/mds/linear-algebra-projections.html#def-design-matrix) of covariate patterns): $$\underbrace{\mathbf{H}}_{q \times q}
\stackrel{\text{def}}{=}
\underbrace{\mathbf{W}^{1/2}}_{q \times q}
\underbrace{\mathbf{X}}_{q \times p}
\mathopen{}\left(\underbrace{{\mathbf{X}}^{\top}\,\mathbf{W}\,\mathbf{X}}_{p \times p}\right)\mathclose{}^{-1}
\underbrace{{\mathbf{X}}^{\top}}_{p \times q}
\underbrace{\mathbf{W}^{1/2}}_{q \times q},
\qquad \underbrace{\mathbf{W}}_{q \times q} \stackrel{\text{def}}{=}\text{diag}\mathopen{}\left(n_k \, \hat\pi_k \, (1 - \hat\pi_k)\right)\mathclose{}$$

## Comparing probabilities

**Risk difference** ([def](../chapters/binary-outcome-associations.llms.md#def-RD)) $$\delta(\pi_1,\pi_2) \stackrel{\text{def}}{=}\pi_1 - \pi_2$$

**Risk ratio** ([def](../chapters/binary-outcome-associations.llms.md#def-RR)) $$\rho(\pi_1,\pi_2) \stackrel{\text{def}}{=}\frac{\pi_1}{\pi_2}$$

**Relative risk difference** ([def](../chapters/binary-outcome-associations.llms.md#def-RRD); equals RR minus 1 by [thm](../chapters/binary-outcome-associations.llms.md#thm-rrd-vs-rr)) $$\xi(\pi_1,\pi_2) \stackrel{\text{def}}{=}\frac{\delta(\pi_1,\pi_2)}{\pi_2} = \rho(\pi_1,\pi_2) - 1$$

## Marginal risks from logistic regression

**Conditional predicted risk** ([def](../chapters/logistic-regression.llms.md#def-cond-predicted-risk)) $$\pi(a, z) \stackrel{\text{def}}{=}\Pr(Y = 1 \mid A = a, Z = z)$$

**Conditional RD and RR** ([def](../chapters/logistic-regression.llms.md#def-cond-rd), [def](../chapters/logistic-regression.llms.md#def-cond-rrr)) $$\text{RD}(z) \stackrel{\text{def}}{=}\pi(1, z) - \pi(0, z),
\qquad \text{RR}(z) \stackrel{\text{def}}{=}\frac{\pi(1, z)}{\pi(0, z)}$$

**Observed marginal risk** ([def](../chapters/logistic-regression.llms.md#def-observed-marginal-risk); standardization form by [thm](../chapters/logistic-regression.llms.md#thm-observed-marginal-risk)) $$\pi(a) \stackrel{\text{def}}{=}\Pr(Y = 1 \mid A = a) = {\mathbb{E}\mathopen{}\left[\pi(a, Z) \mid A = a\right]\mathclose{}}$$

**Potential mean and causal marginal risk** ([def](../chapters/logistic-regression.llms.md#def-potential-mean), [def](../chapters/logistic-regression.llms.md#def-causal-marginal-risk); identification form by [thm](../chapters/logistic-regression.llms.md#thm-causal-marginal-risk)) $$\mu_a \stackrel{\text{def}}{=}{\mathbb{E}\mathopen{}\left[Y^a\right]\mathclose{}},
\qquad \pi_a \stackrel{\text{def}}{=}\Pr(Y^a = 1) = {\mathbb{E}\mathopen{}\left[\pi(a, Z)\right]\mathclose{}}$$

**No confounding: observed = causal** ([cor](../chapters/logistic-regression.llms.md#cor-observed-equals-causal); the two [estimands](https://morrison-lab.github.io/sds/estimation.html#def-estimand) are contrasted in [rem](../chapters/logistic-regression.llms.md#rem-observed-vs-causal-marginal-risk)) $$Z \perp\!\!\!\perp A \implies \pi(a) = \pi_a$$

**G-computation estimator** ([def](../chapters/logistic-regression.llms.md#def-g-computation); consistent for $\pi_a$ by [thm](../chapters/logistic-regression.llms.md#thm-g-computation-consistency)) $$\hat\pi_a \stackrel{\text{def}}{=}\frac{1}{n}\sum_{i=1}^n\hat\pi_{a,i},
\qquad \hat\pi_{a,i} \stackrel{\text{def}}{=}\hat\pi(a, z_i)$$

**Predictive margins** ([def](../chapters/logistic-regression.llms.md#def-predictive-margins); full-sample form [def](../chapters/logistic-regression.llms.md#def-full-sample-predictive-margin) is consistent for $\pi_a$ by [cor](../chapters/logistic-regression.llms.md#cor-full-sample-pm)) $$\widehat{\text{PM}}(a \mid S) \stackrel{\text{def}}{=}\frac{1}{|S|} \sum_{i \in S} \hat\pi_{a,i},
\qquad \widehat{\text{PM}}(a) \stackrel{\text{def}}{=}\frac{1}{n}\sum_{i=1}^n\hat\pi_{a,i} = \hat\pi_a$$

**Exposed-subgroup predictive margin** ([def](../chapters/logistic-regression.llms.md#def-subgroup-predictive-margin); consistent for $\pi(a)$ by [thm](../chapters/logistic-regression.llms.md#thm-subgroup-pm); equals $\bar Y_a$ exactly by [lem](../chapters/logistic-regression.llms.md#lem-subgroup-pm-proportion)) $$\hat\pi_a(a) \stackrel{\text{def}}{=}\frac{1}{n_a} \sum_{i : A_i = a} \hat\pi_{a,i} = \bar Y_a$$

**Observed marginal RD and RR** ([def](../chapters/logistic-regression.llms.md#def-observed-marginal-rd), [def](../chapters/logistic-regression.llms.md#def-observed-marginal-rr)) $$\text{OMRD} \stackrel{\text{def}}{=}\pi(1) - \pi(0),
\qquad \text{OMRR} \stackrel{\text{def}}{=}\frac{\pi(1)}{\pi(0)}$$

**Causal marginal RD and RR** ([def](../chapters/logistic-regression.llms.md#def-causal-marginal-rd), [def](../chapters/logistic-regression.llms.md#def-causal-marginal-rr)) $$\text{CMRD} \stackrel{\text{def}}{=}\pi_1 - \pi_0,
\qquad \text{CMRR} \stackrel{\text{def}}{=}\frac{\pi_1}{\pi_0}$$

**Bootstrap SE and CI for marginal contrasts** ([def](../chapters/logistic-regression.llms.md#def-bootstrap-marginal-rd); see [Bootstrap Confidence Intervals](https://morrison-lab.github.io/sds/bootstrap.html#sec-bootstrap-ci) and [exm](../chapters/logistic-regression.llms.md#exm-wcgs-marginal-rd)): resample the data with replacement $B$ times; refit the logistic model and recompute the marginal contrast on each resample; the bootstrap SE is the [standard deviation](https://morrison-lab.github.io/pds/variance-covariance.html#def-sd) of the $B$ estimates, and a 95% percentile CI uses their 2.5th and 97.5th percentiles.

**Collapsibility** ([def](../chapters/logistic-regression.llms.md#def-collapsibility)): an estimand $\theta$ is collapsible with respect to $Z$ if $$\theta \stackrel{\text{def}}{=}{\mathbb{E}\mathopen{}\left[\theta(Z)\right]\mathclose{}}$$ [Risk differences](../chapters/binary-outcome-associations.llms.md#def-RD) are collapsible; [risk ratios](../chapters/binary-outcome-associations.llms.md#def-RR) and [odds ratios](../chapters/binary-outcome-associations.llms.md#def-OR) are not collapsible in general ([thm](../chapters/logistic-regression.llms.md#thm-collapsibility); counterexample in [exm](../chapters/logistic-regression.llms.md#exm-collapsibility)).

## 4.2 Survival analysis

### 4.2.1 Probability distribution functions

> **NOTE:**
>
> | Name | Symbols | Definition |
> |:---|----|----|
> | [Probability density function (PDF)](https://morrison-lab.github.io/pds/random-variables.html#def-pdf) | $\operatorname{f}(t), \operatorname{p}(t)$ | $\operatorname{p}(T=t)$ |
> | [Cumulative distribution function (CDF)](https://morrison-lab.github.io/pds/random-variables.html#def-cdf) | $\operatorname{F}(t), \mathbb{P}(t)$ | $\mathbb{P}(T\leq t)$ |
> | [Survival function](../chapters/intro-to-survival-analysis.llms.md#def-surv-fn) | $\operatorname{S}(t), \bar{\operatorname{F}}(t)$ | $\mathbb{P}(T > t)$ |
> | [Hazard function](../chapters/intro-to-survival-analysis.llms.md#def-hazard) | $\lambda(t), \operatorname{h}(t)$ | $\operatorname{p}(T=t|T\ge t)$ |
> | [Cumulative hazard function](../chapters/intro-to-survival-analysis.llms.md#def-cuhaz) | $\Lambda(t), \operatorname{H}(t)$ | $\int_{u=-\infty}^t {\lambda}(u)du$ |
> | [Log-hazard function](../chapters/proportional-hazards-models.llms.md#def-loghaz) | $\eta(t)$ | ${\operatorname{log}\mathopen{}\left\{{\lambda}(t)\right\}\mathclose{}}$ |
>
> Table 1: Probability distribution functions

### 4.2.2 Diagram of survival distribution function relationships

$$\operatorname{f}(t)
\xleftarrow[\operatorname{S}(t){\lambda}(t)]{-S'(t)}
\operatorname{S}(t)
\xleftarrow[]{{\operatorname{exp}\mathopen{}\left\{-{\Lambda}(t)\right\}\mathclose{}}}
{\Lambda}(t)
\xleftarrow[]{\int_{u=0}^t {\lambda}(u)du}
{\lambda}(t)
\xleftarrow[]{{\operatorname{exp}\mathopen{}\left\{\eta(t)\right\}\mathclose{}}}
\eta(t)$$

$$\operatorname{f}(t)
\xrightarrow[\int_{u=t}^\infty \operatorname{f}(u)du]{\operatorname{f}(t)/{\lambda}(t)}
\operatorname{S}(t)
\xrightarrow[-\log{\operatorname{S}(t)}]{}
{\Lambda}(t)
\xrightarrow[{\Lambda}'(t)]{}
{\lambda}(t)
\xrightarrow[{\operatorname{log}\mathopen{}\left\{{\lambda}(t)\right\}\mathclose{}}]{}
\eta(t)$$

### 4.2.3 Survival likelihood contributions, assuming non-informative censoring

$$\begin{aligned}
\operatorname{p}(Y=y,D=d)
&= [\operatorname{f}_T(y)]^{d} [\operatorname{S}_T(y)]^{1-d}
\\
&= [{\lambda}_T(y)]^{d} [\operatorname{S}_T(y)]
\end{aligned}$$

### 4.2.4 Nonparametric time-to-event distribution estimators

$$\hat{{\lambda}}_i = \frac{d_i}{r_i}$$

$$\hat{\kappa}_i = 1 - \hat{{\lambda}}_i = \frac{r_i - d_i}{r_i}$$

$${\mathop{\hat{\operatorname{S}}}\nolimits_{\text{KM}}\mathopen{}\left(t\right)\mathclose{}} \stackrel{\text{def}}{=}\prod_{{\mathopen{}\left\{i:\ t_i \le t\right\}\mathclose{}}} \hat{\kappa}_i$$

$$\hat{{\Lambda}}_{NA}(t) \stackrel{\text{def}}{=}\sum_{{\mathopen{}\left\{i:\ t_i \le t\right\}\mathclose{}}}\hat{{\lambda}}_i$$

### 4.2.5 Proportional hazards model structure

| Formula | Description |
|:---|:---|
| ${\lambda}(t\mid\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) = {\lambda}_0(t)\cdot\theta_{{\lambda}}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})$ | [Proportional hazards assumption](../chapters/proportional-hazards-models.llms.md#def-pha) |
| ${\Lambda}(t\mid\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) = {\Lambda}_0(t)\cdot\theta_{{\lambda}}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})$ | [Cumulative hazard factorization](../chapters/proportional-hazards-models.llms.md#thm-ph-cuhaz) |
| $\eta(t\mid\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) = \eta_0(t) + \Delta\eta(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})$ | [Log-hazard decomposition](../chapters/proportional-hazards-models.llms.md#thm-loghaz-decomp) |
| $\Delta\eta(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) = \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}} \cdot \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}} = \beta_1 x_1 + \cdots + \beta_p x_p$ | [Linear predictor](../chapters/Intro-to-GLMs.llms.md#def-linear-predictor) |
| $\theta_{{\lambda}}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) = {\operatorname{exp}\mathopen{}\left\{\Delta\eta(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})\right\}\mathclose{}}$ | [Hazard multiplier](../chapters/proportional-hazards-models.llms.md#def-risk-score) |
| $\text{ϙ}_{{\lambda}}(t| \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}: \mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}) \stackrel{\text{def}}{=}\frac{{\lambda}(t|\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}})}{{\lambda}(t|\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}})}$ | [Hazard ratio definition](../chapters/intro-to-survival-analysis.llms.md#def-hazard-ratio) |
| $\text{ϙ}_{{\lambda}}(t\mid\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}:\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}) = {\operatorname{exp}\mathopen{}\left\{\Delta\eta(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) - \Delta\eta(\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}})\right\}\mathclose{}} = {\operatorname{exp}\mathopen{}\left\{(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}-\mathord{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}^*}}) \cdot \mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}\right\}\mathclose{}}$ | [Hazard ratio formula](../chapters/proportional-hazards-models.llms.md#thm-hazard-ratio-ph) |

### 4.2.6 Proportional hazards model partial likelihood formula:

> **NOTE:**
>
> **Definition 1 (Cox PH partial likelihood)** $$\begin{aligned}
> \mathcal{L}^*_i(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}) &\stackrel{\text{def}}{=}\frac{{\color{red}{\theta_{{\lambda}}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}_{(i)})}}}{\sum_{k \in R(t_i)} {\color{red}{\theta_{{\lambda}}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}_k)}}}
> \\
> \mathcal{L}^*(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}) &\stackrel{\text{def}}{=}
> \prod_{{\mathopen{}\left\{i:\ d_i = 1\right\}\mathclose{}}} \mathcal{L}^*_i(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}})
> \end{aligned}$$
>
> where, for the distinct event times $t_1 < \cdots < t_K$ of the data set:
>
> - $(i)$ is the subject who fails at $t_i$ (unique under the no-ties assumption);
> - $R(t_i) \stackrel{\text{def}}{=}{\mathopen{}\left\{j : Y_j \ge t_i\right\}\mathclose{}}$ is the [risk set](../chapters/intro-to-survival-analysis.llms.md#def-risk-set) at $t_i$ (where $Y_j = \min(T_j, C_j)$ is subject $j$’s observed follow-up time) — the subjects still under observation just before $t_i$;
> - $d_i$ is the number of events at $t_i$ (so $d_i = 1$ when there are no ties);
> - $\theta_{{\lambda}}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) \stackrel{\text{def}}{=}{\operatorname{exp}\mathopen{}\left\{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}}^{\top}\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}\right\}\mathclose{}}$ is the hazard ratio ([risk score](../chapters/proportional-hazards-models.llms.md#def-risk-score)) for covariate pattern $\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}$.

### 4.2.7 Proportional hazards model baseline cumulative hazard estimator:

> **NOTE:**
>
> **Definition 2 (Breslow estimator of the baseline cumulative hazard)** $$\hat {\Lambda}_0(t) \stackrel{\text{def}}{=}
> \sum_{t_i \le t} \frac{d_i}{\sum_{k\in R(t_i)} \theta_{{\lambda}}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}_k)}$$
>
> where, for the distinct event times $t_1 < \cdots < t_K$ of the data set:
>
> - $d_i$ is the number of events at $t_i$;
> - $R(t_i) \stackrel{\text{def}}{=}{\mathopen{}\left\{j : Y_j \ge t_i\right\}\mathclose{}}$ is the [risk set](../chapters/intro-to-survival-analysis.llms.md#def-risk-set) at $t_i$ (where $Y_j = \min(T_j, C_j)$ is subject $j$’s observed follow-up time) — the subjects still under observation just before $t_i$;
> - $\theta_{{\lambda}}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}) \stackrel{\text{def}}{=}{\operatorname{exp}\mathopen{}\left\{{\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}}^{\top}\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{\beta}}\vphantom{\beta}}\right\}\mathclose{}}$ is the hazard ratio ([risk score](../chapters/proportional-hazards-models.llms.md#def-risk-score)) for covariate pattern $\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}$.

> **NOTE:**
>
> **Example 1 (Breslow estimator with two event times)** Suppose there are two distinct event times $t_1 = 2$ and $t_2 = 4$ (no ties, $d_1 = d_2 = 1$), with risk-set-weighted totals $\sum_{k \in R(2)} \theta_{{\lambda}}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}_k) = 10$ and $\sum_{k \in R(4)} \theta_{{\lambda}}(\mathord{\smash[b]{\underset{\raise.3ex\hbox{$\scriptstyle\sim$}}{x}}\vphantom{x}}_k) = 6$. Then
>
> $$\hat{\Lambda}_0(4) = \frac{1}{10} + \frac{1}{6} \approx 0.267 .$$

Back to top

## References

\[1\]

H. Akaike, “A new look at the statistical model identification,” *IEEE Transactions on Automatic Control*, vol. 19, no. 6, pp. 716–723, 1974, Available: <https://doi.org/10.1109/TAC.1974.1100705>

\[2\]

G. Schwarz, “Estimating the dimension of a model,” *The Annals of Statistics*, vol. 6, no. 2, pp. 461–464, 1978, Available: <https://doi.org/10.1214/aos/1176344136>
