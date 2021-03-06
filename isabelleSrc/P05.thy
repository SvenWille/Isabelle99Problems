theory P05 
imports Main 
begin 


primrec p05_1 :: "'a list \<Rightarrow> 'a list" where 
"p05_1 [] = []"|
"p05_1 (x#xs) = p05_1 xs @ [x]"


value "p05_1 [1,2,3,4] :: int list"


lemma [simp] : "p05_1 (ls @ [b]) = b # p05_1 ls " 
apply (induct ls)
apply auto
done 

lemma "p05_1 (p05_1 xs)  = xs" 
proof (induct xs)
  case Nil 
  show ?case by simp
 next 
  fix a xs ls b
  case (Cons a xs)
  assume "p05_1 (p05_1 xs) = xs"
  thus "p05_1 (p05_1 (a # xs)) = a # xs " by simp
qed

lemma "p05_1 ls = rev ls"
  apply (induct ls)
   apply simp_all
  done

lemma "length ls = length (p05_1 ls)"
  apply (induct ls)
   apply simp_all
  done   
  
lemma "p05_1 (p05_1 ls ) = ls" by (induct ls; simp_all)
    
    
    
lemma "\<forall>x .x \<in> set ls \<Longrightarrow> x \<in> set (p05_1 ls)  " 
proof (induct ls)
  case Nil
  then show ?case by simp
next
  case (Cons a ls)
  assume a:" \<forall>x. x \<in> set (a # ls)"
     and b:"(\<forall>x. x \<in> set ls \<Longrightarrow> x \<in> set (p05_1 ls))"
  with a  show ?case 
qed

lemma "set ls = set (p05_1 ls)"
proof (induct ls)
  case Nil
  then show ?case by simp
next
  case (Cons a ls)
  then show ?case 
  proof (cases "a \<in> set ls")
    case True
    then show ?thesis by (simp add: Cons.hyps)
  next
    case False
    then show ?thesis by (simp add : Cons.hyps)
  qed
qed
  