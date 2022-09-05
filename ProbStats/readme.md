# Probability and Statistics

Life is uncertain, and so is nature. Probability is a mathematical framework to describe, quantify and reason about such phenomena whose outcomes are uncertain. By modeling such uncertain phenomena or behaviours, it allows us to make predictions of likelihood of future events. We need statistical information about the real-world in order to create a probabilistic model. Statistics is the practice or science of collecting, analyzing and interpreting the frequency of past events or numerical data in large quantities, especially for the purpose of inferring proportions in a whole from those in a representative sample. i.e It allows to make estimates about the real-nature using just a sample of data or when we don't have complete information. Hence, both Probability and Statistics are interrelated topics.

A probabilistic space that models random process consists of three important elements:

1. Sample Space $$\omega$$: A set of all possible outcomes of an experiment, where the outcomes are 
  - mutually exclusive (if this happens, that doesn't occur), 
  - collectively exhaustive (all possible outcomes are included, anythin outside $$\omega$$ is not possible) and 
  - are at right granularity (right level of details are accounted for, i.e without irrelevant informations).
2. Event Space $$E$$: A collection of events, where each event is a subset of sample space 
3. Probability Distribution (function or measure) $$P:E \rightarrow \mathbb R$$: A function $$P(\cdot)$$ that takes in an event and returns a real number between [0,1] indicating the chance of the event occuring. This follows certain probabilistic laws or axioms to assign probability to outcomes:
  - Non-Negativity: $$P(E) \geq 0$$: also implies $$P(\emptyset) = 0$$
  - Normalization: $$P(\omega) = 1$$ : $$\omega$$ is collectively exhaustive.
  - Finite Additivity: For two disjoint events (i.e. $$A \cap B = \emptyset$$): $$P(A \cup B) = P(A) + P(B)$$
    - Extends to a set of mutually exclusive events: $P(E_1 \cup E_2 \cup \dots E_n) = P(E_1) + P(E_2) + \dots + P(E_n)$
    - Defines compliments with normalization: $P(\omega) = P(E) + P(E^c) = 1, \Quad \therefore P(E^c) = 1 - P(E) $
  - Conditional Probability for overlapping events $P(A | B) = \frac{P(A \cap B)}{P(B)}$ defines 
    - Multiplication rule of probability or composite probability: $P(A \cap B) = P(A|B) \times P(B) = P(B|A) \ times P(A)$ 
    - Generalize Total Probability Theorem: $P(B) = P(B \cap A) + P(B \ cap A^c)$, this allows to partition the sample space as weighted average of probabilities of an Event i.e $P(B) = P(A_1) \times P(B|A_1) + P(A_2) \times P(B|A_2) + \dots P(A_n) \times P(B|A_n)$
    - Bayes Rule $P(H|E) = \frac{P(E|H)P(H)}{P(E)}$ allows to evaluate posterior (revised belief about hypothesis H given evidence E has occured) with prior beliefs (Probability that hypothesis H has occured), likelihood of evidence E occuring given hypothesis marginalized by the probability of Evidence being true
    - independent events $P(B|A) = P(B)$ i.e occurance of A provides no information about occurance of B. Note: Disjoint events are dependent events i.e if A has occured implies that event $P(B|A)=0$
      - dependent: $P(A \cap B) = P(A) P(B|A)$, 
      - independet: $P(A \cap B) = P(A) P(B)$   
