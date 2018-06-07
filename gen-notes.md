# General Notes

Consider we have a mapping from $X$ to $Y$ ($f: X \rightarrow Y$). Then some terms are defined
as follows:
\begin{equation}
\begin{array}{rl}
\text{function axiom}: & \forall x,x' \in X: x=x' \Rightarrow f(x)=f(x') \\
f\,\text{is injective}: & \forall x,x' \in X: f(x)=f(x') \Rightarrow x=x' \\
f\,\text{is surjective}: & \forall y \in Y, \exists x \in X: f(x)=y \\
f\,\text{is bijective}: & f\,\text{is injective} \land f\,\text{is surjective}
\end{array}
\end{equation}

---

In minisat the polarities in DIMACS, Literal structure and bit structure
are like this:<br>
+x : sign=false : x,0<br>
-x : sign=true  : x,1

---

The SHA-1 state update relation is:
\begin{equation}
    A_{i+1} = (A_i \lll 5) + w_i + f(A_{i-1}, A_{i-2} \ggg 2, A_{i-3} \ggg 2)
    + (A_{i-4} \ggg 2) + K_i
\end{equation}
