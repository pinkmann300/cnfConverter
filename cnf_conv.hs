{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
type Prop = [Char]
-- Allowed a string and not just one character since we do not  know the length of the variable name. (Trying to keep it as general as possible.)

data Formula =  Var Prop | And Formula Formula | Not Formula | Or Formula Formula | Implies Formula Formula | Iff Formula Formula
                deriving (Show,Read)

-- Recursive definition of formulas
-- With the above description, all formulas can be generated

-- Desugaring the sugary terms. We get rid of the Implies and the Iff terms.

desugar :: Formula -> Formula
desugar (Implies x y) = Or (Not (desugar x)) (desugar y)
desugar (Iff x y) = And (desugar (Implies (desugar x) (desugar y))) (desugar (Implies (desugar y) (desugar x)))
desugar (And x y) = And (desugar x) (desugar y)
desugar (Or x y) = Or (desugar x) (desugar y)
desugar (Not x) = Not (desugar x)
desugar (Var x) = Var x

-- We have completed step 1 of converting it into an NNF
-- Once we convert it to NNF, conversion to CNF will become easier

nnf :: Formula -> Formula
nnf (Var x) = Var x
nnf (Not (Not x)) = nnf x
nnf (Not (And x y)) = Or (Not (nnf x)) (Not (nnf y))
nnf (Not (Or x y)) = And (Not (nnf x)) (Not (nnf y))
nnf (Or x y) = Or (nnf x) (nnf y)
nnf (And x y) = And (nnf x) (nnf y)
nnf (Not (Var x)) = Not (Var x)

nnfConvert :: Formula -> Formula 
nnfConvert xs = nnf (desugar xs)

cnf :: Formula -> Formula 
cnf (Var x) = Var x
cnf (And x y) = And (cnf x) (cnf y)
cnf (Or x (And k y)) = And (Or (cnf x) (cnf k)) (Or (cnf x) (cnf y))
cnf (Not (Not x)) = cnf x
cnf (Not x) = Not (cnf x)
cnf (Or x (Or k y)) = Or (cnf x) (Or (cnf k) (cnf y))
cnf (Or x y) = Or (cnf x) (cnf y)


cnfConvert :: Formula -> Formula 
cnfConvert xs = cnf (nnfConvert xs)


p1, p2, p3 :: Formula 
p1 = Var "P"
p2 = Var "Q"
p3 = Var "R"

p12 = Implies p1 p2
p23 = And p2 p3
pfin = Or p12 p23
