# cnfConverter
Built this to convert any given propositional logic formula into it's equivalent CNF (Conjuctive Normal form). You also have the option to convert a given formula into it's NNF (Negation Normal Form) but that is just an intermediate step in converting an arbitrary formula to its CNF equivalent. The inspiration behind this project is from my Automated Reasoning class which I took in the final trimester of my undergraduate program at Krea University. 

The converter is built completely using Haskell. The main reason was to exercise the functional capability of the language and write a correct program for the same. 

Illustrating the process:
  FORMULA ---> Desugaring Process ---> NNF Conversion ---> *NNF* ---> CNF Conversion ---> *CNF*
  
If you find the program to be erroneous for any propositional logic formula, please feel free to initiate a pull request. 


