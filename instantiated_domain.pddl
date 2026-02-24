(define (domain trace-alignment)

  (:requirements :strips :typing :equality :adl :fluents :action-costs)

  (:types activity automaton_state trace_state parameter_name value_name constraint resource)


  (:predicates 
    ;; TRACES AND AUTOMATONS
    (trace ?t1 - trace_state ?a - activity ?t2 - trace_state)
    (automaton ?s1 - automaton_state ?a - activity ?s2 - automaton_state)
    (cur_t_state ?t - trace_state)
    (cur_s_state ?s - automaton_state)
    (goal_state ?s - automaton_state)
    (final_t_state ?t - trace_state)
    (violated ?c - constraint)
    (initial_state ?s1 - automaton_state) 
    
    (associated ?s1 - automaton_state ?c - constraint)
    (can_work ?a - activity ?r - resource)

    ;; PARAMETER AND CONSTRAINT DECLARATION
    (has_parameter ?a - activity ?pn - parameter_name ?t1 - trace_state ?t2 - trace_state)
    (has_constraint ?a - activity ?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state)

    ; Predicates to keep track of planner progress
    (invalid ?s1 - automaton_state ?a - activity ?s2 - automaton_state)
    (complete_sync ?a - activity)
    (after_sync)
    (after_add)
    (after_add_check)

    (recovery_finished)

    ; Declare this to indicate that such activity-parameter-value assignment exists.
    (has_substitution_value ?vn - value_name ?a - activity ?pn - parameter_name)
    ; Indicates that the new activity has a new (defined) parameter.
    (has_added_parameter_aut ?a - activity ?par - parameter_name ?s1 - automaton_state)

    ; Used in the problem definition to indicate that this state must not be reached. In that case, the trace is **automatically** failed.
    (failure_state ?s - automaton_state)
    ; Used to indicate that the trace alignment couldn't possibly complete: prune -> less branching -> heap won't kaboom.
    (failure)

  )

  (:functions
    (total_cost)

    ; There exists a value connected to the activity that occures between the two trace states.
    (trace_parameter ?a - activity ?pn - parameter_name ?t1 - trace_state ?t2 - trace_state)
    (majority_constraint ?a - activity ?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state)
    (minority_constraint ?a - activity ?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state)
    (interval_constraint_lower ?a - activity ?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state)
    (interval_constraint_higher ?a - activity ?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state)
    (equality_constraint ?a - activity ?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state)
    (inequality_constraint ?a - activity ?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state)

    ;; VARIABLES SUBSTITUTION / ADDITION
    (variable_value ?var - value_name)
    (added_parameter_aut ?a - activity ?par - parameter_name ?s1 - automaton_state)
    ;; Cost functions
    (violation_cost ?c - constraint)
    (activity_cost ?a - activity ?r - resource)

  )
    
    	(:action add_parameter_a16_S6_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a16 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a16 ?s2) (has_constraint a16 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S6 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S6 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S6 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S6 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S6) (assign (added_parameter_aut a16 integer S6) (variable_value v5)))
	)

	(:action add_parameter_a16_S6_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a16 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a16 ?s2) (has_constraint a16 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S6 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S6 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S6 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S6 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S6) (assign (added_parameter_aut a16 integer S6) (variable_value v15)))
	)

	(:action add_parameter_a11_S12_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a11 categorical S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a11 ?s2) (has_constraint a11 categorical S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S12 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S12 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S12 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S12 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S12) (assign (added_parameter_aut a11 categorical S12) (variable_value c1)))
	)

	(:action add_parameter_a12_S11_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a12 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a12 ?s2) (has_constraint a12 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S11 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S11 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S11 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S11 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S11) (assign (added_parameter_aut a12 integer S11) (variable_value v5)))
	)

	(:action add_parameter_a16_S6_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a16 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a16 ?s2) (has_constraint a16 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S6 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S6 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S6 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S6 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S6) (assign (added_parameter_aut a16 integer S6) (variable_value v0)))
	)

	(:action add_parameter_a16_S6_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a16 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a16 ?s2) (has_constraint a16 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S6 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S6 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S6 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S6 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S6) (assign (added_parameter_aut a16 integer S6) (variable_value v30)))
	)

	(:action add_parameter_a12_S11_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a12 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a12 ?s2) (has_constraint a12 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S11 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S11 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S11 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S11 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S11) (assign (added_parameter_aut a12 integer S11) (variable_value v0)))
	)

	(:action add_parameter_a12_S11_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a12 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a12 ?s2) (has_constraint a12 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S11 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S11 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S11 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S11 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S11) (assign (added_parameter_aut a12 integer S11) (variable_value v15)))
	)

	(:action add_parameter_a11_S12_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a11 categorical S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a11 ?s2) (has_constraint a11 categorical S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S12 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S12 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S12 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S12 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S12) (assign (added_parameter_aut a11 categorical S12) (variable_value c2)))
	)

	(:action add_parameter_a1_sDEC1_2_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a1 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a1 ?s2) (has_constraint a1 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer sDEC1_2 ?s2)) (< (variable_value v30) (minority_constraint a1 integer sDEC1_2 ?s2)) (= (variable_value v30) (equality_constraint a1 integer sDEC1_2 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer sDEC1_2 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer sDEC1_2) (assign (added_parameter_aut a1 integer sDEC1_2) (variable_value v30)))
	)

	(:action add_parameter_a1_sDEC1_2_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a1 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a1 ?s2) (has_constraint a1 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer sDEC1_2 ?s2)) (< (variable_value v15) (minority_constraint a1 integer sDEC1_2 ?s2)) (= (variable_value v15) (equality_constraint a1 integer sDEC1_2 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer sDEC1_2 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer sDEC1_2) (assign (added_parameter_aut a1 integer sDEC1_2) (variable_value v15)))
	)

	(:action add_parameter_a1_sDEC1_2_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a1 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a1 ?s2) (has_constraint a1 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer sDEC1_2 ?s2)) (< (variable_value v0) (minority_constraint a1 integer sDEC1_2 ?s2)) (= (variable_value v0) (equality_constraint a1 integer sDEC1_2 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer sDEC1_2 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer sDEC1_2) (assign (added_parameter_aut a1 integer sDEC1_2) (variable_value v0)))
	)

	(:action add_parameter_a1_sDEC1_2_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a1 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a1 ?s2) (has_constraint a1 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer sDEC1_2 ?s2)) (< (variable_value v5) (minority_constraint a1 integer sDEC1_2 ?s2)) (= (variable_value v5) (equality_constraint a1 integer sDEC1_2 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer sDEC1_2 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer sDEC1_2) (assign (added_parameter_aut a1 integer sDEC1_2) (variable_value v5)))
	)

	(:action check_added_parameter_model_a9
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a9 ?s2) (has_constraint a9 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a9 ?pn ?s1)) (and (has_added_parameter_aut a9 ?pn ?s1) (or (< (added_parameter_aut a9 ?pn ?s1) (majority_constraint a9 ?pn ?s1 ?s2)) (> (added_parameter_aut a9 ?pn ?s1) (minority_constraint a9 ?pn ?s1 ?s2)) (< (added_parameter_aut a9 ?pn ?s1) (interval_constraint_lower a9 ?pn ?s1 ?s2)) (> (added_parameter_aut a9 ?pn ?s1) (interval_constraint_higher a9 ?pn ?s1 ?s2)) (< (added_parameter_aut a9 ?pn ?s1) (equality_constraint a9 ?pn ?s1 ?s2)) (> (added_parameter_aut a9 ?pn ?s1) (equality_constraint a9 ?pn ?s1 ?s2)) (= (added_parameter_aut a9 ?pn ?s1) (inequality_constraint a9 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a9 ?s2)) ) )
	)

	(:action add_parameter_a3_S10_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a3 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a3 ?s2) (has_constraint a3 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S10 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S10 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S10 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S10 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S10) (assign (added_parameter_aut a3 integer S10) (variable_value v5)))
	)

	(:action check_added_parameter_model_a1
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a1 ?s2) (has_constraint a1 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a1 ?pn ?s1)) (and (has_added_parameter_aut a1 ?pn ?s1) (or (< (added_parameter_aut a1 ?pn ?s1) (majority_constraint a1 ?pn ?s1 ?s2)) (> (added_parameter_aut a1 ?pn ?s1) (minority_constraint a1 ?pn ?s1 ?s2)) (< (added_parameter_aut a1 ?pn ?s1) (interval_constraint_lower a1 ?pn ?s1 ?s2)) (> (added_parameter_aut a1 ?pn ?s1) (interval_constraint_higher a1 ?pn ?s1 ?s2)) (< (added_parameter_aut a1 ?pn ?s1) (equality_constraint a1 ?pn ?s1 ?s2)) (> (added_parameter_aut a1 ?pn ?s1) (equality_constraint a1 ?pn ?s1 ?s2)) (= (added_parameter_aut a1 ?pn ?s1) (inequality_constraint a1 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a1 ?s2)) ) )
	)

	(:action add_parameter_a11_S12_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a11 categorical S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a11 ?s2) (has_constraint a11 categorical S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S12 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S12 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S12 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S12 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S12) (assign (added_parameter_aut a11 categorical S12) (variable_value c3)))
	)

	(:action add_parameter_a12_S11_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a12 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a12 ?s2) (has_constraint a12 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S11 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S11 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S11 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S11 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S11) (assign (added_parameter_aut a12 integer S11) (variable_value v30)))
	)

	(:action check_added_parameter_model_a2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a2 ?s2) (has_constraint a2 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a2 ?pn ?s1)) (and (has_added_parameter_aut a2 ?pn ?s1) (or (< (added_parameter_aut a2 ?pn ?s1) (majority_constraint a2 ?pn ?s1 ?s2)) (> (added_parameter_aut a2 ?pn ?s1) (minority_constraint a2 ?pn ?s1 ?s2)) (< (added_parameter_aut a2 ?pn ?s1) (interval_constraint_lower a2 ?pn ?s1 ?s2)) (> (added_parameter_aut a2 ?pn ?s1) (interval_constraint_higher a2 ?pn ?s1 ?s2)) (< (added_parameter_aut a2 ?pn ?s1) (equality_constraint a2 ?pn ?s1 ?s2)) (> (added_parameter_aut a2 ?pn ?s1) (equality_constraint a2 ?pn ?s1 ?s2)) (= (added_parameter_aut a2 ?pn ?s1) (inequality_constraint a2 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a2 ?s2)) ) )
	)

	(:action add_parameter_a18_S16_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a18 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a18 ?s2) (has_constraint a18 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S16 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S16 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S16 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S16 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S16) (assign (added_parameter_aut a18 integer S16) (variable_value v30)))
	)

	(:action check_added_parameter_model_a3
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a3 ?s2) (has_constraint a3 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a3 ?pn ?s1)) (and (has_added_parameter_aut a3 ?pn ?s1) (or (< (added_parameter_aut a3 ?pn ?s1) (majority_constraint a3 ?pn ?s1 ?s2)) (> (added_parameter_aut a3 ?pn ?s1) (minority_constraint a3 ?pn ?s1 ?s2)) (< (added_parameter_aut a3 ?pn ?s1) (interval_constraint_lower a3 ?pn ?s1 ?s2)) (> (added_parameter_aut a3 ?pn ?s1) (interval_constraint_higher a3 ?pn ?s1 ?s2)) (< (added_parameter_aut a3 ?pn ?s1) (equality_constraint a3 ?pn ?s1 ?s2)) (> (added_parameter_aut a3 ?pn ?s1) (equality_constraint a3 ?pn ?s1 ?s2)) (= (added_parameter_aut a3 ?pn ?s1) (inequality_constraint a3 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a3 ?s2)) ) )
	)

	(:action add_parameter_a18_S16_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a18 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a18 ?s2) (has_constraint a18 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S16 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S16 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S16 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S16 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S16) (assign (added_parameter_aut a18 integer S16) (variable_value v0)))
	)

	(:action check_added_parameter_model_a4
		:parameters ()
		:precondition (and (complete_sync a4) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a4 ?s2) (has_constraint a4 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a4 ?pn ?s1)) (and (has_added_parameter_aut a4 ?pn ?s1) (or (< (added_parameter_aut a4 ?pn ?s1) (majority_constraint a4 ?pn ?s1 ?s2)) (> (added_parameter_aut a4 ?pn ?s1) (minority_constraint a4 ?pn ?s1 ?s2)) (< (added_parameter_aut a4 ?pn ?s1) (interval_constraint_lower a4 ?pn ?s1 ?s2)) (> (added_parameter_aut a4 ?pn ?s1) (interval_constraint_higher a4 ?pn ?s1 ?s2)) (< (added_parameter_aut a4 ?pn ?s1) (equality_constraint a4 ?pn ?s1 ?s2)) (> (added_parameter_aut a4 ?pn ?s1) (equality_constraint a4 ?pn ?s1 ?s2)) (= (added_parameter_aut a4 ?pn ?s1) (inequality_constraint a4 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a4 ?s2)) ) )
	)

	(:action add_parameter_a3_S10_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a3 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a3 ?s2) (has_constraint a3 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S10 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S10 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S10 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S10 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S10) (assign (added_parameter_aut a3 integer S10) (variable_value v15)))
	)

	(:action add_parameter_a18_S16_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a18 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a18 ?s2) (has_constraint a18 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S16 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S16 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S16 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S16 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S16) (assign (added_parameter_aut a18 integer S16) (variable_value v15)))
	)

	(:action check_added_parameter_model_a5
		:parameters ()
		:precondition (and (complete_sync a5) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a5 ?s2) (has_constraint a5 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a5 ?pn ?s1)) (and (has_added_parameter_aut a5 ?pn ?s1) (or (< (added_parameter_aut a5 ?pn ?s1) (majority_constraint a5 ?pn ?s1 ?s2)) (> (added_parameter_aut a5 ?pn ?s1) (minority_constraint a5 ?pn ?s1 ?s2)) (< (added_parameter_aut a5 ?pn ?s1) (interval_constraint_lower a5 ?pn ?s1 ?s2)) (> (added_parameter_aut a5 ?pn ?s1) (interval_constraint_higher a5 ?pn ?s1 ?s2)) (< (added_parameter_aut a5 ?pn ?s1) (equality_constraint a5 ?pn ?s1 ?s2)) (> (added_parameter_aut a5 ?pn ?s1) (equality_constraint a5 ?pn ?s1 ?s2)) (= (added_parameter_aut a5 ?pn ?s1) (inequality_constraint a5 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a5 ?s2)) ) )
	)

	(:action check_added_parameter_model_a6
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a6 ?s2) (has_constraint a6 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a6 ?pn ?s1)) (and (has_added_parameter_aut a6 ?pn ?s1) (or (< (added_parameter_aut a6 ?pn ?s1) (majority_constraint a6 ?pn ?s1 ?s2)) (> (added_parameter_aut a6 ?pn ?s1) (minority_constraint a6 ?pn ?s1 ?s2)) (< (added_parameter_aut a6 ?pn ?s1) (interval_constraint_lower a6 ?pn ?s1 ?s2)) (> (added_parameter_aut a6 ?pn ?s1) (interval_constraint_higher a6 ?pn ?s1 ?s2)) (< (added_parameter_aut a6 ?pn ?s1) (equality_constraint a6 ?pn ?s1 ?s2)) (> (added_parameter_aut a6 ?pn ?s1) (equality_constraint a6 ?pn ?s1 ?s2)) (= (added_parameter_aut a6 ?pn ?s1) (inequality_constraint a6 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a6 ?s2)) ) )
	)

	(:action add_parameter_a3_S10_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a3 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a3 ?s2) (has_constraint a3 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S10 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S10 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S10 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S10 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S10) (assign (added_parameter_aut a3 integer S10) (variable_value v30)))
	)

	(:action add_parameter_a18_S16_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a18 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a18 ?s2) (has_constraint a18 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S16 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S16 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S16 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S16 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S16) (assign (added_parameter_aut a18 integer S16) (variable_value v5)))
	)

	(:action check_added_parameter_model_a7
		:parameters ()
		:precondition (and (complete_sync a7) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a7 ?s2) (has_constraint a7 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a7 ?pn ?s1)) (and (has_added_parameter_aut a7 ?pn ?s1) (or (< (added_parameter_aut a7 ?pn ?s1) (majority_constraint a7 ?pn ?s1 ?s2)) (> (added_parameter_aut a7 ?pn ?s1) (minority_constraint a7 ?pn ?s1 ?s2)) (< (added_parameter_aut a7 ?pn ?s1) (interval_constraint_lower a7 ?pn ?s1 ?s2)) (> (added_parameter_aut a7 ?pn ?s1) (interval_constraint_higher a7 ?pn ?s1 ?s2)) (< (added_parameter_aut a7 ?pn ?s1) (equality_constraint a7 ?pn ?s1 ?s2)) (> (added_parameter_aut a7 ?pn ?s1) (equality_constraint a7 ?pn ?s1 ?s2)) (= (added_parameter_aut a7 ?pn ?s1) (inequality_constraint a7 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a7 ?s2)) ) )
	)

	(:action add_parameter_a3_S10_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a3 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a3 ?s2) (has_constraint a3 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S10 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S10 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S10 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S10 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S10) (assign (added_parameter_aut a3 integer S10) (variable_value v0)))
	)

	(:action check_added_parameter_model_a8
		:parameters ()
		:precondition (and (complete_sync a8) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a8 ?s2) (has_constraint a8 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a8 ?pn ?s1)) (and (has_added_parameter_aut a8 ?pn ?s1) (or (< (added_parameter_aut a8 ?pn ?s1) (majority_constraint a8 ?pn ?s1 ?s2)) (> (added_parameter_aut a8 ?pn ?s1) (minority_constraint a8 ?pn ?s1 ?s2)) (< (added_parameter_aut a8 ?pn ?s1) (interval_constraint_lower a8 ?pn ?s1 ?s2)) (> (added_parameter_aut a8 ?pn ?s1) (interval_constraint_higher a8 ?pn ?s1 ?s2)) (< (added_parameter_aut a8 ?pn ?s1) (equality_constraint a8 ?pn ?s1 ?s2)) (> (added_parameter_aut a8 ?pn ?s1) (equality_constraint a8 ?pn ?s1 ?s2)) (= (added_parameter_aut a8 ?pn ?s1) (inequality_constraint a8 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a8 ?s2)) ) )
	)

	(:action add_parameter_a15_S9_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a15 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a15 ?s2) (has_constraint a15 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S9 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S9 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S9 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S9 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S9) (assign (added_parameter_aut a15 integer S9) (variable_value v5)))
	)

	(:action add_parameter_a15_S9_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a15 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a15 ?s2) (has_constraint a15 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S9 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S9 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S9 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S9 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S9) (assign (added_parameter_aut a15 integer S9) (variable_value v0)))
	)

	(:action add_parameter_a15_S9_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a15 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a15 ?s2) (has_constraint a15 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S9 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S9 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S9 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S9 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S9) (assign (added_parameter_aut a15 integer S9) (variable_value v15)))
	)

	(:action add_parameter_a19_S4_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a19 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a19 ?s2) (has_constraint a19 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S4 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S4 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S4 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S4 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S4) (assign (added_parameter_aut a19 integer S4) (variable_value v30)))
	)

	(:action add_parameter_a19_S4_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a19 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a19 ?s2) (has_constraint a19 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S4 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S4 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S4 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S4 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S4) (assign (added_parameter_aut a19 integer S4) (variable_value v0)))
	)

	(:action add_parameter_a19_S4_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a19 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a19 ?s2) (has_constraint a19 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S4 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S4 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S4 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S4 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S4) (assign (added_parameter_aut a19 integer S4) (variable_value v15)))
	)

	(:action add_parameter_a19_S4_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a19 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a19 ?s2) (has_constraint a19 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S4 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S4 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S4 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S4 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S4) (assign (added_parameter_aut a19 integer S4) (variable_value v5)))
	)

	(:action add_parameter_a9_S4_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a9 categorical S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a9 ?s2) (has_constraint a9 categorical S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S4 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S4 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S4 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S4 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S4) (assign (added_parameter_aut a9 categorical S4) (variable_value c2)))
	)

	(:action add_parameter_a9_S4_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a9 categorical S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a9 ?s2) (has_constraint a9 categorical S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S4 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S4 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S4 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S4 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S4) (assign (added_parameter_aut a9 categorical S4) (variable_value c1)))
	)

	(:action add_parameter_a15_S9_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a15 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a15 ?s2) (has_constraint a15 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S9 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S9 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S9 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S9 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S9) (assign (added_parameter_aut a15 integer S9) (variable_value v30)))
	)

	(:action add_parameter_a9_S4_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a9 categorical S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a9 ?s2) (has_constraint a9 categorical S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S4 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S4 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S4 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S4 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S4) (assign (added_parameter_aut a9 categorical S4) (variable_value c3)))
	)

	(:action add_parameter_a10_S15_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a10 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a10 ?s2) (has_constraint a10 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S15 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S15 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S15 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S15 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S15) (assign (added_parameter_aut a10 integer S15) (variable_value v5)))
	)

	(:action add_parameter_a11_S0_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a11 categorical S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a11 ?s2) (has_constraint a11 categorical S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S0 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S0 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S0 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S0 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S0) (assign (added_parameter_aut a11 categorical S0) (variable_value c3)))
	)

	(:action add_parameter_a18_S3_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a18 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a18 ?s2) (has_constraint a18 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S3 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S3 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S3 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S3 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S3) (assign (added_parameter_aut a18 integer S3) (variable_value v30)))
	)

	(:action add_parameter_a18_S3_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a18 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a18 ?s2) (has_constraint a18 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S3 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S3 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S3 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S3 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S3) (assign (added_parameter_aut a18 integer S3) (variable_value v0)))
	)

	(:action add_parameter_a18_S3_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a18 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a18 ?s2) (has_constraint a18 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S3 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S3 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S3 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S3 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S3) (assign (added_parameter_aut a18 integer S3) (variable_value v15)))
	)

	(:action add_parameter_a18_S3_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a18 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a18 ?s2) (has_constraint a18 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S3 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S3 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S3 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S3 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S3) (assign (added_parameter_aut a18 integer S3) (variable_value v5)))
	)

	(:action add_parameter_a2_S15_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a2 categorical S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a2 ?s2) (has_constraint a2 categorical S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S15 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S15 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S15 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S15 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S15) (assign (added_parameter_aut a2 categorical S15) (variable_value c2)))
	)

	(:action add_parameter_a6_S17_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a6 categorical S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a6 ?s2) (has_constraint a6 categorical S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S17 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S17 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S17 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S17 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S17) (assign (added_parameter_aut a6 categorical S17) (variable_value c1)))
	)

	(:action add_parameter_a6_S17_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a6 categorical S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a6 ?s2) (has_constraint a6 categorical S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S17 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S17 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S17 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S17 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S17) (assign (added_parameter_aut a6 categorical S17) (variable_value c2)))
	)

	(:action add_parameter_a10_S15_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a10 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a10 ?s2) (has_constraint a10 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S15 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S15 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S15 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S15 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S15) (assign (added_parameter_aut a10 integer S15) (variable_value v30)))
	)

	(:action add_parameter_a2_S15_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a2 categorical S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a2 ?s2) (has_constraint a2 categorical S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S15 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S15 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S15 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S15 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S15) (assign (added_parameter_aut a2 categorical S15) (variable_value c3)))
	)

	(:action add_parameter_a6_S17_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a6 categorical S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a6 ?s2) (has_constraint a6 categorical S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S17 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S17 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S17 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S17 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S17) (assign (added_parameter_aut a6 categorical S17) (variable_value c3)))
	)

	(:action add_parameter_a1_S12_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a1 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a1 ?s2) (has_constraint a1 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S12 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S12 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S12 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S12 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S12) (assign (added_parameter_aut a1 integer S12) (variable_value v0)))
	)

	(:action add_parameter_a10_S15_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a10 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a10 ?s2) (has_constraint a10 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S15 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S15 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S15 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S15 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S15) (assign (added_parameter_aut a10 integer S15) (variable_value v15)))
	)

	(:action add_parameter_a1_S12_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a1 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a1 ?s2) (has_constraint a1 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S12 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S12 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S12 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S12 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S12) (assign (added_parameter_aut a1 integer S12) (variable_value v30)))
	)

	(:action add_parameter_a10_S15_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a10 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a10 ?s2) (has_constraint a10 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S15 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S15 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S15 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S15 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S15) (assign (added_parameter_aut a10 integer S15) (variable_value v0)))
	)

	(:action add_parameter_a2_S15_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a2 categorical S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a2 ?s2) (has_constraint a2 categorical S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S15 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S15 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S15 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S15 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S15) (assign (added_parameter_aut a2 categorical S15) (variable_value c1)))
	)

	(:action add_parameter_a1_S12_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a1 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a1 ?s2) (has_constraint a1 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S12 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S12 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S12 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S12 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S12) (assign (added_parameter_aut a1 integer S12) (variable_value v15)))
	)

	(:action add_parameter_a1_S12_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a1 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a1 ?s2) (has_constraint a1 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S12 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S12 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S12 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S12 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S12) (assign (added_parameter_aut a1 integer S12) (variable_value v5)))
	)

	(:action check_added_parameter_model_a12
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a12 ?s2) (has_constraint a12 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a12 ?pn ?s1)) (and (has_added_parameter_aut a12 ?pn ?s1) (or (< (added_parameter_aut a12 ?pn ?s1) (majority_constraint a12 ?pn ?s1 ?s2)) (> (added_parameter_aut a12 ?pn ?s1) (minority_constraint a12 ?pn ?s1 ?s2)) (< (added_parameter_aut a12 ?pn ?s1) (interval_constraint_lower a12 ?pn ?s1 ?s2)) (> (added_parameter_aut a12 ?pn ?s1) (interval_constraint_higher a12 ?pn ?s1 ?s2)) (< (added_parameter_aut a12 ?pn ?s1) (equality_constraint a12 ?pn ?s1 ?s2)) (> (added_parameter_aut a12 ?pn ?s1) (equality_constraint a12 ?pn ?s1 ?s2)) (= (added_parameter_aut a12 ?pn ?s1) (inequality_constraint a12 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a12 ?s2)) ) )
	)

	(:action check_added_parameter_model_a15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a15 ?s2) (has_constraint a15 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a15 ?pn ?s1)) (and (has_added_parameter_aut a15 ?pn ?s1) (or (< (added_parameter_aut a15 ?pn ?s1) (majority_constraint a15 ?pn ?s1 ?s2)) (> (added_parameter_aut a15 ?pn ?s1) (minority_constraint a15 ?pn ?s1 ?s2)) (< (added_parameter_aut a15 ?pn ?s1) (interval_constraint_lower a15 ?pn ?s1 ?s2)) (> (added_parameter_aut a15 ?pn ?s1) (interval_constraint_higher a15 ?pn ?s1 ?s2)) (< (added_parameter_aut a15 ?pn ?s1) (equality_constraint a15 ?pn ?s1 ?s2)) (> (added_parameter_aut a15 ?pn ?s1) (equality_constraint a15 ?pn ?s1 ?s2)) (= (added_parameter_aut a15 ?pn ?s1) (inequality_constraint a15 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a15 ?s2)) ) )
	)

	(:action check_added_parameter_model_a14
		:parameters ()
		:precondition (and (complete_sync a14) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a14 ?s2) (has_constraint a14 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a14 ?pn ?s1)) (and (has_added_parameter_aut a14 ?pn ?s1) (or (< (added_parameter_aut a14 ?pn ?s1) (majority_constraint a14 ?pn ?s1 ?s2)) (> (added_parameter_aut a14 ?pn ?s1) (minority_constraint a14 ?pn ?s1 ?s2)) (< (added_parameter_aut a14 ?pn ?s1) (interval_constraint_lower a14 ?pn ?s1 ?s2)) (> (added_parameter_aut a14 ?pn ?s1) (interval_constraint_higher a14 ?pn ?s1 ?s2)) (< (added_parameter_aut a14 ?pn ?s1) (equality_constraint a14 ?pn ?s1 ?s2)) (> (added_parameter_aut a14 ?pn ?s1) (equality_constraint a14 ?pn ?s1 ?s2)) (= (added_parameter_aut a14 ?pn ?s1) (inequality_constraint a14 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a14 ?s2)) ) )
	)

	(:action check_added_parameter_model_a17
		:parameters ()
		:precondition (and (complete_sync a17) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a17 ?s2) (has_constraint a17 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a17 ?pn ?s1)) (and (has_added_parameter_aut a17 ?pn ?s1) (or (< (added_parameter_aut a17 ?pn ?s1) (majority_constraint a17 ?pn ?s1 ?s2)) (> (added_parameter_aut a17 ?pn ?s1) (minority_constraint a17 ?pn ?s1 ?s2)) (< (added_parameter_aut a17 ?pn ?s1) (interval_constraint_lower a17 ?pn ?s1 ?s2)) (> (added_parameter_aut a17 ?pn ?s1) (interval_constraint_higher a17 ?pn ?s1 ?s2)) (< (added_parameter_aut a17 ?pn ?s1) (equality_constraint a17 ?pn ?s1 ?s2)) (> (added_parameter_aut a17 ?pn ?s1) (equality_constraint a17 ?pn ?s1 ?s2)) (= (added_parameter_aut a17 ?pn ?s1) (inequality_constraint a17 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a17 ?s2)) ) )
	)

	(:action check_added_parameter_model_a16
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a16 ?s2) (has_constraint a16 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a16 ?pn ?s1)) (and (has_added_parameter_aut a16 ?pn ?s1) (or (< (added_parameter_aut a16 ?pn ?s1) (majority_constraint a16 ?pn ?s1 ?s2)) (> (added_parameter_aut a16 ?pn ?s1) (minority_constraint a16 ?pn ?s1 ?s2)) (< (added_parameter_aut a16 ?pn ?s1) (interval_constraint_lower a16 ?pn ?s1 ?s2)) (> (added_parameter_aut a16 ?pn ?s1) (interval_constraint_higher a16 ?pn ?s1 ?s2)) (< (added_parameter_aut a16 ?pn ?s1) (equality_constraint a16 ?pn ?s1 ?s2)) (> (added_parameter_aut a16 ?pn ?s1) (equality_constraint a16 ?pn ?s1 ?s2)) (= (added_parameter_aut a16 ?pn ?s1) (inequality_constraint a16 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a16 ?s2)) ) )
	)

	(:action check_added_parameter_model_a19
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a19 ?s2) (has_constraint a19 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a19 ?pn ?s1)) (and (has_added_parameter_aut a19 ?pn ?s1) (or (< (added_parameter_aut a19 ?pn ?s1) (majority_constraint a19 ?pn ?s1 ?s2)) (> (added_parameter_aut a19 ?pn ?s1) (minority_constraint a19 ?pn ?s1 ?s2)) (< (added_parameter_aut a19 ?pn ?s1) (interval_constraint_lower a19 ?pn ?s1 ?s2)) (> (added_parameter_aut a19 ?pn ?s1) (interval_constraint_higher a19 ?pn ?s1 ?s2)) (< (added_parameter_aut a19 ?pn ?s1) (equality_constraint a19 ?pn ?s1 ?s2)) (> (added_parameter_aut a19 ?pn ?s1) (equality_constraint a19 ?pn ?s1 ?s2)) (= (added_parameter_aut a19 ?pn ?s1) (inequality_constraint a19 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a19 ?s2)) ) )
	)

	(:action check_added_parameter_model_a18
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a18 ?s2) (has_constraint a18 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a18 ?pn ?s1)) (and (has_added_parameter_aut a18 ?pn ?s1) (or (< (added_parameter_aut a18 ?pn ?s1) (majority_constraint a18 ?pn ?s1 ?s2)) (> (added_parameter_aut a18 ?pn ?s1) (minority_constraint a18 ?pn ?s1 ?s2)) (< (added_parameter_aut a18 ?pn ?s1) (interval_constraint_lower a18 ?pn ?s1 ?s2)) (> (added_parameter_aut a18 ?pn ?s1) (interval_constraint_higher a18 ?pn ?s1 ?s2)) (< (added_parameter_aut a18 ?pn ?s1) (equality_constraint a18 ?pn ?s1 ?s2)) (> (added_parameter_aut a18 ?pn ?s1) (equality_constraint a18 ?pn ?s1 ?s2)) (= (added_parameter_aut a18 ?pn ?s1) (inequality_constraint a18 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a18 ?s2)) ) )
	)

	(:action check_added_parameter_model_a0
		:parameters ()
		:precondition (and (complete_sync a0) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a0 ?s2) (has_constraint a0 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a0 ?pn ?s1)) (and (has_added_parameter_aut a0 ?pn ?s1) (or (< (added_parameter_aut a0 ?pn ?s1) (majority_constraint a0 ?pn ?s1 ?s2)) (> (added_parameter_aut a0 ?pn ?s1) (minority_constraint a0 ?pn ?s1 ?s2)) (< (added_parameter_aut a0 ?pn ?s1) (interval_constraint_lower a0 ?pn ?s1 ?s2)) (> (added_parameter_aut a0 ?pn ?s1) (interval_constraint_higher a0 ?pn ?s1 ?s2)) (< (added_parameter_aut a0 ?pn ?s1) (equality_constraint a0 ?pn ?s1 ?s2)) (> (added_parameter_aut a0 ?pn ?s1) (equality_constraint a0 ?pn ?s1 ?s2)) (= (added_parameter_aut a0 ?pn ?s1) (inequality_constraint a0 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a0 ?s2)) ) )
	)

	(:action check_added_parameter_model_a11
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a11 ?s2) (has_constraint a11 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a11 ?pn ?s1)) (and (has_added_parameter_aut a11 ?pn ?s1) (or (< (added_parameter_aut a11 ?pn ?s1) (majority_constraint a11 ?pn ?s1 ?s2)) (> (added_parameter_aut a11 ?pn ?s1) (minority_constraint a11 ?pn ?s1 ?s2)) (< (added_parameter_aut a11 ?pn ?s1) (interval_constraint_lower a11 ?pn ?s1 ?s2)) (> (added_parameter_aut a11 ?pn ?s1) (interval_constraint_higher a11 ?pn ?s1 ?s2)) (< (added_parameter_aut a11 ?pn ?s1) (equality_constraint a11 ?pn ?s1 ?s2)) (> (added_parameter_aut a11 ?pn ?s1) (equality_constraint a11 ?pn ?s1 ?s2)) (= (added_parameter_aut a11 ?pn ?s1) (inequality_constraint a11 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a11 ?s2)) ) )
	)

	(:action check_added_parameter_model_a10
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a10 ?s2) (has_constraint a10 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a10 ?pn ?s1)) (and (has_added_parameter_aut a10 ?pn ?s1) (or (< (added_parameter_aut a10 ?pn ?s1) (majority_constraint a10 ?pn ?s1 ?s2)) (> (added_parameter_aut a10 ?pn ?s1) (minority_constraint a10 ?pn ?s1 ?s2)) (< (added_parameter_aut a10 ?pn ?s1) (interval_constraint_lower a10 ?pn ?s1 ?s2)) (> (added_parameter_aut a10 ?pn ?s1) (interval_constraint_higher a10 ?pn ?s1 ?s2)) (< (added_parameter_aut a10 ?pn ?s1) (equality_constraint a10 ?pn ?s1 ?s2)) (> (added_parameter_aut a10 ?pn ?s1) (equality_constraint a10 ?pn ?s1 ?s2)) (= (added_parameter_aut a10 ?pn ?s1) (inequality_constraint a10 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a10 ?s2)) ) )
	)

	(:action check_added_parameter_model_a13
		:parameters ()
		:precondition (and (complete_sync a13) (after_add) (not (after_add_check)))
		:effect (and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a13 ?s2) (has_constraint a13 ?pn ?s1 ?s2) (or (not (has_added_parameter_aut a13 ?pn ?s1)) (and (has_added_parameter_aut a13 ?pn ?s1) (or (< (added_parameter_aut a13 ?pn ?s1) (majority_constraint a13 ?pn ?s1 ?s2)) (> (added_parameter_aut a13 ?pn ?s1) (minority_constraint a13 ?pn ?s1 ?s2)) (< (added_parameter_aut a13 ?pn ?s1) (interval_constraint_lower a13 ?pn ?s1 ?s2)) (> (added_parameter_aut a13 ?pn ?s1) (interval_constraint_higher a13 ?pn ?s1 ?s2)) (< (added_parameter_aut a13 ?pn ?s1) (equality_constraint a13 ?pn ?s1 ?s2)) (> (added_parameter_aut a13 ?pn ?s1) (equality_constraint a13 ?pn ?s1 ?s2)) (= (added_parameter_aut a13 ?pn ?s1) (inequality_constraint a13 ?pn ?s1 ?s2)) ) ) ) ) (invalid ?s1 a13 ?s2)) ) )
	)

	(:action add_parameter_a11_S0_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a11 categorical S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a11 ?s2) (has_constraint a11 categorical S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S0 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S0 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S0 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S0 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S0) (assign (added_parameter_aut a11 categorical S0) (variable_value c1)))
	)

	(:action add_parameter_a11_S0_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a11 categorical S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a11 ?s2) (has_constraint a11 categorical S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S0 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S0 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S0 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S0 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S0) (assign (added_parameter_aut a11 categorical S0) (variable_value c2)))
	)

	(:action add_parameter_a11_S13_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a11 categorical S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a11 ?s2) (has_constraint a11 categorical S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S13 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S13 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S13 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S13 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S13) (assign (added_parameter_aut a11 categorical S13) (variable_value c2)))
	)

	(:action add_parameter_a12_S17_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a12 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a12 ?s2) (has_constraint a12 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S17 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S17 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S17 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S17 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S17) (assign (added_parameter_aut a12 integer S17) (variable_value v5)))
	)

	(:action add_parameter_a12_S17_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a12 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a12 ?s2) (has_constraint a12 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S17 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S17 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S17 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S17 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S17) (assign (added_parameter_aut a12 integer S17) (variable_value v0)))
	)

	(:action add_parameter_a12_S17_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a12 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a12 ?s2) (has_constraint a12 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S17 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S17 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S17 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S17 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S17) (assign (added_parameter_aut a12 integer S17) (variable_value v15)))
	)

	(:action add_parameter_a12_S17_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a12 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a12 ?s2) (has_constraint a12 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S17 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S17 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S17 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S17 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S17) (assign (added_parameter_aut a12 integer S17) (variable_value v30)))
	)

	(:action add_parameter_a11_S13_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a11 categorical S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a11 ?s2) (has_constraint a11 categorical S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S13 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S13 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S13 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S13 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S13) (assign (added_parameter_aut a11 categorical S13) (variable_value c1)))
	)

	(:action add_parameter_a16_S3_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a16 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a16 ?s2) (has_constraint a16 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S3 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S3 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S3 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S3 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S3) (assign (added_parameter_aut a16 integer S3) (variable_value v30)))
	)

	(:action add_parameter_a16_S3_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a16 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a16 ?s2) (has_constraint a16 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S3 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S3 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S3 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S3 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S3) (assign (added_parameter_aut a16 integer S3) (variable_value v0)))
	)

	(:action add_parameter_a16_S3_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a16 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a16 ?s2) (has_constraint a16 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S3 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S3 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S3 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S3 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S3) (assign (added_parameter_aut a16 integer S3) (variable_value v15)))
	)

	(:action add_parameter_a16_S3_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a16 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a16 ?s2) (has_constraint a16 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S3 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S3 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S3 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S3 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S3) (assign (added_parameter_aut a16 integer S3) (variable_value v5)))
	)

	(:action add_parameter_a18_S12_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a18 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a18 ?s2) (has_constraint a18 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S12 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S12 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S12 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S12 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S12) (assign (added_parameter_aut a18 integer S12) (variable_value v5)))
	)

	(:action add_parameter_a3_S9_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a3 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a3 ?s2) (has_constraint a3 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S9 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S9 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S9 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S9 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S9) (assign (added_parameter_aut a3 integer S9) (variable_value v5)))
	)

	(:action add_parameter_a3_S9_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a3 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a3 ?s2) (has_constraint a3 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S9 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S9 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S9 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S9 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S9) (assign (added_parameter_aut a3 integer S9) (variable_value v15)))
	)

	(:action add_parameter_a11_S13_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a11 categorical S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a11 ?s2) (has_constraint a11 categorical S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S13 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S13 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S13 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S13 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S13) (assign (added_parameter_aut a11 categorical S13) (variable_value c3)))
	)

	(:action add_parameter_a3_S9_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a3 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a3 ?s2) (has_constraint a3 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S9 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S9 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S9 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S9 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S9) (assign (added_parameter_aut a3 integer S9) (variable_value v30)))
	)

	(:action add_parameter_a18_S12_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a18 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a18 ?s2) (has_constraint a18 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S12 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S12 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S12 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S12 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S12) (assign (added_parameter_aut a18 integer S12) (variable_value v30)))
	)

	(:action add_parameter_a3_S9_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a3 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a3 ?s2) (has_constraint a3 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S9 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S9 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S9 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S9 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S9) (assign (added_parameter_aut a3 integer S9) (variable_value v0)))
	)

	(:action add_parameter_a18_S12_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a18 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a18 ?s2) (has_constraint a18 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S12 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S12 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S12 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S12 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S12) (assign (added_parameter_aut a18 integer S12) (variable_value v0)))
	)

	(:action add_parameter_a18_S12_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a18 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a18 ?s2) (has_constraint a18 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S12 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S12 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S12 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S12 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S12) (assign (added_parameter_aut a18 integer S12) (variable_value v15)))
	)

	(:action add_parameter_a15_S8_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a15 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a15 ?s2) (has_constraint a15 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S8 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S8 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S8 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S8 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S8) (assign (added_parameter_aut a15 integer S8) (variable_value v5)))
	)

	(:action add_parameter_a15_S8_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a15 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a15 ?s2) (has_constraint a15 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S8 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S8 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S8 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S8 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S8) (assign (added_parameter_aut a15 integer S8) (variable_value v0)))
	)

	(:action add_parameter_a15_S8_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a15 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a15 ?s2) (has_constraint a15 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S8 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S8 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S8 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S8 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S8) (assign (added_parameter_aut a15 integer S8) (variable_value v15)))
	)

	(:action add_parameter_a15_S8_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a15 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a15 ?s2) (has_constraint a15 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S8 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S8 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S8 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S8 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S8) (assign (added_parameter_aut a15 integer S8) (variable_value v30)))
	)

	(:action add_parameter_a19_S2_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a19 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a19 ?s2) (has_constraint a19 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S2 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S2 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S2 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S2 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S2) (assign (added_parameter_aut a19 integer S2) (variable_value v30)))
	)

	(:action add_parameter_a19_S2_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a19 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a19 ?s2) (has_constraint a19 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S2 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S2 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S2 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S2 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S2) (assign (added_parameter_aut a19 integer S2) (variable_value v0)))
	)

	(:action add_parameter_a19_S2_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a19 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a19 ?s2) (has_constraint a19 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S2 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S2 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S2 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S2 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S2) (assign (added_parameter_aut a19 integer S2) (variable_value v15)))
	)

	(:action add_parameter_a19_S2_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a19 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a19 ?s2) (has_constraint a19 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S2 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S2 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S2 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S2 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S2) (assign (added_parameter_aut a19 integer S2) (variable_value v5)))
	)

	(:action add_parameter_a9_S2_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a9 categorical S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a9 ?s2) (has_constraint a9 categorical S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S2 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S2 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S2 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S2 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S2) (assign (added_parameter_aut a9 categorical S2) (variable_value c1)))
	)

	(:action add_parameter_a9_S2_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a9 categorical S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a9 ?s2) (has_constraint a9 categorical S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S2 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S2 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S2 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S2 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S2) (assign (added_parameter_aut a9 categorical S2) (variable_value c2)))
	)

	(:action add_parameter_a9_S2_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a9 categorical S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a9 ?s2) (has_constraint a9 categorical S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S2 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S2 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S2 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S2 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S2) (assign (added_parameter_aut a9 categorical S2) (variable_value c3)))
	)

	(:action add_parameter_a9_S18_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a9 categorical S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a9 ?s2) (has_constraint a9 categorical S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S18 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S18 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S18 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S18 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S18) (assign (added_parameter_aut a9 categorical S18) (variable_value c2)))
	)

	(:action add_parameter_a10_S1_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a10 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a10 ?s2) (has_constraint a10 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S1 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S1 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S1 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S1 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S1) (assign (added_parameter_aut a10 integer S1) (variable_value v15)))
	)

	(:action add_parameter_a10_S1_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a10 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a10 ?s2) (has_constraint a10 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S1 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S1 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S1 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S1 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S1) (assign (added_parameter_aut a10 integer S1) (variable_value v0)))
	)

	(:action add_parameter_a9_S18_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a9 categorical S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a9 ?s2) (has_constraint a9 categorical S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S18 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S18 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S18 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S18 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S18) (assign (added_parameter_aut a9 categorical S18) (variable_value c1)))
	)

	(:action add_parameter_a10_S1_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a10 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a10 ?s2) (has_constraint a10 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S1 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S1 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S1 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S1 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S1) (assign (added_parameter_aut a10 integer S1) (variable_value v5)))
	)

	(:action add_parameter_a11_sDEC1_2_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a11 categorical sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a11 ?s2) (has_constraint a11 categorical sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical sDEC1_2 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical sDEC1_2 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical sDEC1_2 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical sDEC1_2 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical sDEC1_2) (assign (added_parameter_aut a11 categorical sDEC1_2) (variable_value c3)))
	)

	(:action add_parameter_a9_S18_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a9 categorical S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a9 ?s2) (has_constraint a9 categorical S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S18 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S18 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S18 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S18 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S18) (assign (added_parameter_aut a9 categorical S18) (variable_value c3)))
	)

	(:action add_parameter_a18_S0_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a18 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a18 ?s2) (has_constraint a18 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S0 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S0 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S0 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S0 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S0) (assign (added_parameter_aut a18 integer S0) (variable_value v30)))
	)

	(:action add_parameter_a18_S0_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a18 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a18 ?s2) (has_constraint a18 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S0 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S0 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S0 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S0 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S0) (assign (added_parameter_aut a18 integer S0) (variable_value v0)))
	)

	(:action add_parameter_a18_S0_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a18 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a18 ?s2) (has_constraint a18 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S0 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S0 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S0 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S0 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S0) (assign (added_parameter_aut a18 integer S0) (variable_value v15)))
	)

	(:action add_parameter_a18_S0_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a18 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a18 ?s2) (has_constraint a18 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S0 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S0 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S0 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S0 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S0) (assign (added_parameter_aut a18 integer S0) (variable_value v5)))
	)

	(:action add_parameter_a2_S1_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a2 categorical S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a2 ?s2) (has_constraint a2 categorical S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S1 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S1 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S1 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S1 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S1) (assign (added_parameter_aut a2 categorical S1) (variable_value c2)))
	)

	(:action add_parameter_a6_S7_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a6 categorical S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a6 ?s2) (has_constraint a6 categorical S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S7 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S7 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S7 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S7 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S7) (assign (added_parameter_aut a6 categorical S7) (variable_value c2)))
	)

	(:action add_parameter_a1_S13_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a1 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a1 ?s2) (has_constraint a1 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S13 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S13 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S13 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S13 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S13) (assign (added_parameter_aut a1 integer S13) (variable_value v5)))
	)

	(:action add_parameter_a2_S1_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a2 categorical S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a2 ?s2) (has_constraint a2 categorical S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S1 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S1 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S1 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S1 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S1) (assign (added_parameter_aut a2 categorical S1) (variable_value c1)))
	)

	(:action add_parameter_a6_S7_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a6 categorical S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a6 ?s2) (has_constraint a6 categorical S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S7 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S7 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S7 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S7 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S7) (assign (added_parameter_aut a6 categorical S7) (variable_value c1)))
	)

	(:action add_parameter_a10_S1_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a10 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a10 ?s2) (has_constraint a10 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S1 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S1 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S1 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S1 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S1) (assign (added_parameter_aut a10 integer S1) (variable_value v30)))
	)

	(:action add_parameter_a6_S7_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a6 categorical S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a6 ?s2) (has_constraint a6 categorical S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S7 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S7 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S7 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S7 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S7) (assign (added_parameter_aut a6 categorical S7) (variable_value c3)))
	)

	(:action add_parameter_a1_S13_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a1 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a1 ?s2) (has_constraint a1 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S13 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S13 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S13 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S13 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S13) (assign (added_parameter_aut a1 integer S13) (variable_value v0)))
	)

	(:action add_parameter_a1_S13_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a1 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a1 ?s2) (has_constraint a1 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S13 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S13 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S13 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S13 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S13) (assign (added_parameter_aut a1 integer S13) (variable_value v30)))
	)

	(:action add_parameter_a2_S1_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a2 categorical S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a2 ?s2) (has_constraint a2 categorical S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S1 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S1 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S1 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S1 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S1) (assign (added_parameter_aut a2 categorical S1) (variable_value c3)))
	)

	(:action add_parameter_a1_S13_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a1 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a1 ?s2) (has_constraint a1 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S13 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S13 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S13 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S13 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S13) (assign (added_parameter_aut a1 integer S13) (variable_value v15)))
	)

	(:action add_parameter_a11_sDEC1_2_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a11 categorical sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a11 ?s2) (has_constraint a11 categorical sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical sDEC1_2 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical sDEC1_2 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical sDEC1_2 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical sDEC1_2 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical sDEC1_2) (assign (added_parameter_aut a11 categorical sDEC1_2) (variable_value c2)))
	)

	(:action add_parameter_a11_sDEC1_2_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a11 categorical sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a11 ?s2) (has_constraint a11 categorical sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical sDEC1_2 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical sDEC1_2 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical sDEC1_2 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical sDEC1_2 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical sDEC1_2) (assign (added_parameter_aut a11 categorical sDEC1_2) (variable_value c1)))
	)

	(:action add_parameter_a19_S18_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a19 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a19 ?s2) (has_constraint a19 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S18 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S18 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S18 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S18 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S18) (assign (added_parameter_aut a19 integer S18) (variable_value v30)))
	)

	(:action add_parameter_a19_S18_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a19 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a19 ?s2) (has_constraint a19 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S18 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S18 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S18 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S18 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S18) (assign (added_parameter_aut a19 integer S18) (variable_value v0)))
	)

	(:action add_parameter_a19_S18_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a19 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a19 ?s2) (has_constraint a19 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S18 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S18 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S18 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S18 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S18) (assign (added_parameter_aut a19 integer S18) (variable_value v15)))
	)

	(:action add_parameter_a19_S18_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a19 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a19 ?s2) (has_constraint a19 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S18 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S18 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S18 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S18 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S18) (assign (added_parameter_aut a19 integer S18) (variable_value v5)))
	)

	(:action add_parameter_a16_S17_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a16 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a16 ?s2) (has_constraint a16 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S17 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S17 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S17 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S17 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S17) (assign (added_parameter_aut a16 integer S17) (variable_value v5)))
	)

	(:action add_parameter_a1_S3_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a1 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a1 ?s2) (has_constraint a1 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S3 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S3 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S3 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S3 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S3) (assign (added_parameter_aut a1 integer S3) (variable_value v15)))
	)

	(:action add_parameter_a1_S3_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a1 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a1 ?s2) (has_constraint a1 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S3 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S3 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S3 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S3 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S3) (assign (added_parameter_aut a1 integer S3) (variable_value v0)))
	)

	(:action add_parameter_a2_S2_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a2 categorical S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a2 ?s2) (has_constraint a2 categorical S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S2 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S2 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S2 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S2 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S2) (assign (added_parameter_aut a2 categorical S2) (variable_value c1)))
	)

	(:action add_parameter_a10_S2_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a10 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a10 ?s2) (has_constraint a10 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S2 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S2 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S2 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S2 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S2) (assign (added_parameter_aut a10 integer S2) (variable_value v15)))
	)

	(:action add_parameter_a1_S3_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a1 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a1 ?s2) (has_constraint a1 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S3 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S3 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S3 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S3 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S3) (assign (added_parameter_aut a1 integer S3) (variable_value v5)))
	)

	(:action add_parameter_a10_S2_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a10 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a10 ?s2) (has_constraint a10 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S2 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S2 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S2 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S2 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S2) (assign (added_parameter_aut a10 integer S2) (variable_value v5)))
	)

	(:action add_parameter_a10_S2_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a10 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a10 ?s2) (has_constraint a10 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S2 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S2 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S2 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S2 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S2) (assign (added_parameter_aut a10 integer S2) (variable_value v0)))
	)

	(:action add_parameter_a10_S2_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a10 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a10 ?s2) (has_constraint a10 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S2 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S2 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S2 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S2 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S2) (assign (added_parameter_aut a10 integer S2) (variable_value v30)))
	)

	(:action add_parameter_a2_S2_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a2 categorical S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a2 ?s2) (has_constraint a2 categorical S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S2 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S2 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S2 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S2 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S2) (assign (added_parameter_aut a2 categorical S2) (variable_value c2)))
	)

	(:action add_parameter_a2_S2_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a2 categorical S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a2 ?s2) (has_constraint a2 categorical S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S2 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S2 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S2 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S2 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S2) (assign (added_parameter_aut a2 categorical S2) (variable_value c3)))
	)

	(:action add_parameter_a1_S3_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a1 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a1 ?s2) (has_constraint a1 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S3 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S3 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S3 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S3 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S3) (assign (added_parameter_aut a1 integer S3) (variable_value v30)))
	)

	(:action add_parameter_a3_S12_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a3 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a3 ?s2) (has_constraint a3 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S12 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S12 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S12 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S12 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S12) (assign (added_parameter_aut a3 integer S12) (variable_value v15)))
	)

	(:action add_parameter_a16_S17_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a16 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a16 ?s2) (has_constraint a16 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S17 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S17 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S17 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S17 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S17) (assign (added_parameter_aut a16 integer S17) (variable_value v15)))
	)

	(:action add_parameter_a12_S15_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a12 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a12 ?s2) (has_constraint a12 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S15 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S15 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S15 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S15 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S15) (assign (added_parameter_aut a12 integer S15) (variable_value v5)))
	)

	(:action add_parameter_a16_S17_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a16 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a16 ?s2) (has_constraint a16 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S17 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S17 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S17 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S17 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S17) (assign (added_parameter_aut a16 integer S17) (variable_value v0)))
	)

	(:action add_parameter_a3_S12_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a3 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a3 ?s2) (has_constraint a3 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S12 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S12 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S12 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S12 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S12) (assign (added_parameter_aut a3 integer S12) (variable_value v30)))
	)

	(:action add_parameter_a16_S17_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a16 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a16 ?s2) (has_constraint a16 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S17 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S17 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S17 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S17 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S17) (assign (added_parameter_aut a16 integer S17) (variable_value v30)))
	)

	(:action add_parameter_a12_S15_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a12 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a12 ?s2) (has_constraint a12 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S15 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S15 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S15 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S15 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S15) (assign (added_parameter_aut a12 integer S15) (variable_value v0)))
	)

	(:action add_parameter_a12_S15_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a12 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a12 ?s2) (has_constraint a12 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S15 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S15 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S15 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S15 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S15) (assign (added_parameter_aut a12 integer S15) (variable_value v15)))
	)

	(:action add_parameter_a3_S12_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a3 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a3 ?s2) (has_constraint a3 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S12 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S12 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S12 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S12 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S12) (assign (added_parameter_aut a3 integer S12) (variable_value v0)))
	)

	(:action add_parameter_a12_S15_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a12 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a12 ?s2) (has_constraint a12 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S15 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S15 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S15 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S15 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S15) (assign (added_parameter_aut a12 integer S15) (variable_value v30)))
	)

	(:action add_parameter_a3_S12_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a3 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a3 ?s2) (has_constraint a3 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S12 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S12 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S12 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S12 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S12) (assign (added_parameter_aut a3 integer S12) (variable_value v5)))
	)

	(:action add_parameter_a2_S18_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a2 categorical S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a2 ?s2) (has_constraint a2 categorical S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S18 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S18 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S18 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S18 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S18) (assign (added_parameter_aut a2 categorical S18) (variable_value c3)))
	)

	(:action add_parameter_a19_S8_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a19 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a19 ?s2) (has_constraint a19 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S8 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S8 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S8 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S8 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S8) (assign (added_parameter_aut a19 integer S8) (variable_value v5)))
	)

	(:action add_parameter_a19_S8_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a19 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a19 ?s2) (has_constraint a19 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S8 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S8 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S8 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S8 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S8) (assign (added_parameter_aut a19 integer S8) (variable_value v30)))
	)

	(:action add_parameter_a9_S8_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a9 categorical S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a9 ?s2) (has_constraint a9 categorical S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S8 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S8 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S8 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S8 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S8) (assign (added_parameter_aut a9 categorical S8) (variable_value c2)))
	)

	(:action add_parameter_a19_S8_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a19 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a19 ?s2) (has_constraint a19 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S8 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S8 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S8 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S8 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S8) (assign (added_parameter_aut a19 integer S8) (variable_value v0)))
	)

	(:action add_parameter_a19_S8_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a19 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a19 ?s2) (has_constraint a19 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S8 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S8 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S8 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S8 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S8) (assign (added_parameter_aut a19 integer S8) (variable_value v15)))
	)

	(:action add_parameter_a15_S13_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a15 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a15 ?s2) (has_constraint a15 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S13 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S13 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S13 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S13 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S13) (assign (added_parameter_aut a15 integer S13) (variable_value v5)))
	)

	(:action add_parameter_a15_S13_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a15 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a15 ?s2) (has_constraint a15 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S13 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S13 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S13 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S13 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S13) (assign (added_parameter_aut a15 integer S13) (variable_value v0)))
	)

	(:action add_parameter_a9_S8_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a9 categorical S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a9 ?s2) (has_constraint a9 categorical S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S8 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S8 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S8 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S8 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S8) (assign (added_parameter_aut a9 categorical S8) (variable_value c1)))
	)

	(:action add_parameter_a15_S13_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a15 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a15 ?s2) (has_constraint a15 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S13 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S13 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S13 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S13 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S13) (assign (added_parameter_aut a15 integer S13) (variable_value v15)))
	)

	(:action add_parameter_a15_S13_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a15 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a15 ?s2) (has_constraint a15 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S13 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S13 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S13 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S13 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S13) (assign (added_parameter_aut a15 integer S13) (variable_value v30)))
	)

	(:action add_parameter_a9_S8_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a9 categorical S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a9 ?s2) (has_constraint a9 categorical S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S8 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S8 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S8 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S8 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S8) (assign (added_parameter_aut a9 categorical S8) (variable_value c3)))
	)

	(:action add_parameter_a11_S6_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a11 categorical S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a11 ?s2) (has_constraint a11 categorical S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S6 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S6 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S6 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S6 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S6) (assign (added_parameter_aut a11 categorical S6) (variable_value c1)))
	)

	(:action add_parameter_a12_sDEC1_1_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a12 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a12 ?s2) (has_constraint a12 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer sDEC1_1 ?s2)) (< (variable_value v5) (minority_constraint a12 integer sDEC1_1 ?s2)) (= (variable_value v5) (equality_constraint a12 integer sDEC1_1 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer sDEC1_1 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer sDEC1_1) (assign (added_parameter_aut a12 integer sDEC1_1) (variable_value v5)))
	)

	(:action add_parameter_a18_S7_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a18 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a18 ?s2) (has_constraint a18 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S7 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S7 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S7 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S7 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S7) (assign (added_parameter_aut a18 integer S7) (variable_value v5)))
	)

	(:action add_parameter_a3_S0_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a3 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a3 ?s2) (has_constraint a3 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S0 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S0 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S0 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S0 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S0) (assign (added_parameter_aut a3 integer S0) (variable_value v5)))
	)

	(:action add_parameter_a12_sDEC1_1_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a12 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a12 ?s2) (has_constraint a12 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer sDEC1_1 ?s2)) (< (variable_value v15) (minority_constraint a12 integer sDEC1_1 ?s2)) (= (variable_value v15) (equality_constraint a12 integer sDEC1_1 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer sDEC1_1 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer sDEC1_1) (assign (added_parameter_aut a12 integer sDEC1_1) (variable_value v15)))
	)

	(:action add_parameter_a3_S0_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a3 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a3 ?s2) (has_constraint a3 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S0 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S0 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S0 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S0 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S0) (assign (added_parameter_aut a3 integer S0) (variable_value v0)))
	)

	(:action add_parameter_a11_S6_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a11 categorical S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a11 ?s2) (has_constraint a11 categorical S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S6 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S6 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S6 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S6 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S6) (assign (added_parameter_aut a11 categorical S6) (variable_value c2)))
	)

	(:action add_parameter_a3_S0_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a3 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a3 ?s2) (has_constraint a3 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S0 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S0 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S0 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S0 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S0) (assign (added_parameter_aut a3 integer S0) (variable_value v15)))
	)

	(:action add_parameter_a11_S6_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a11 categorical S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a11 ?s2) (has_constraint a11 categorical S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S6 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S6 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S6 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S6 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S6) (assign (added_parameter_aut a11 categorical S6) (variable_value c3)))
	)

	(:action add_parameter_a12_sDEC1_1_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a12 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a12 ?s2) (has_constraint a12 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer sDEC1_1 ?s2)) (< (variable_value v30) (minority_constraint a12 integer sDEC1_1 ?s2)) (= (variable_value v30) (equality_constraint a12 integer sDEC1_1 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer sDEC1_1 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer sDEC1_1) (assign (added_parameter_aut a12 integer sDEC1_1) (variable_value v30)))
	)

	(:action add_parameter_a12_sDEC1_1_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a12 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a12 ?s2) (has_constraint a12 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer sDEC1_1 ?s2)) (< (variable_value v0) (minority_constraint a12 integer sDEC1_1 ?s2)) (= (variable_value v0) (equality_constraint a12 integer sDEC1_1 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer sDEC1_1 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer sDEC1_1) (assign (added_parameter_aut a12 integer sDEC1_1) (variable_value v0)))
	)

	(:action add_parameter_a3_S0_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a3 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a3 ?s2) (has_constraint a3 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S0 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S0 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S0 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S0 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S0) (assign (added_parameter_aut a3 integer S0) (variable_value v30)))
	)

	(:action add_parameter_a18_S7_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a18 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a18 ?s2) (has_constraint a18 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S7 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S7 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S7 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S7 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S7) (assign (added_parameter_aut a18 integer S7) (variable_value v30)))
	)

	(:action add_parameter_a18_S7_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a18 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a18 ?s2) (has_constraint a18 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S7 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S7 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S7 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S7 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S7) (assign (added_parameter_aut a18 integer S7) (variable_value v0)))
	)

	(:action add_parameter_a18_S7_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a18 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a18 ?s2) (has_constraint a18 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S7 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S7 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S7 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S7 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S7) (assign (added_parameter_aut a18 integer S7) (variable_value v15)))
	)

	(:action add_parameter_a2_S18_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a2 categorical S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a2 ?s2) (has_constraint a2 categorical S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S18 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S18 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S18 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S18 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S18) (assign (added_parameter_aut a2 categorical S18) (variable_value c1)))
	)

	(:action add_parameter_a10_S18_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a10 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a10 ?s2) (has_constraint a10 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S18 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S18 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S18 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S18 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S18) (assign (added_parameter_aut a10 integer S18) (variable_value v5)))
	)

	(:action add_parameter_a6_S1_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a6 categorical S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a6 ?s2) (has_constraint a6 categorical S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S1 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S1 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S1 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S1 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S1) (assign (added_parameter_aut a6 categorical S1) (variable_value c3)))
	)

	(:action add_parameter_a10_S18_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a10 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a10 ?s2) (has_constraint a10 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S18 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S18 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S18 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S18 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S18) (assign (added_parameter_aut a10 integer S18) (variable_value v30)))
	)

	(:action add_parameter_a6_S1_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a6 categorical S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a6 ?s2) (has_constraint a6 categorical S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S1 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S1 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S1 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S1 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S1) (assign (added_parameter_aut a6 categorical S1) (variable_value c2)))
	)

	(:action add_parameter_a2_S18_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a2 categorical S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a2 ?s2) (has_constraint a2 categorical S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S18 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S18 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S18 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S18 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S18) (assign (added_parameter_aut a2 categorical S18) (variable_value c2)))
	)

	(:action add_parameter_a10_S18_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a10 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a10 ?s2) (has_constraint a10 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S18 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S18 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S18 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S18 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S18) (assign (added_parameter_aut a10 integer S18) (variable_value v15)))
	)

	(:action add_parameter_a10_S18_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a10 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a10 ?s2) (has_constraint a10 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S18 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S18 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S18 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S18 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S18) (assign (added_parameter_aut a10 integer S18) (variable_value v0)))
	)

	(:action add_parameter_a6_S1_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a6 categorical S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a6 ?s2) (has_constraint a6 categorical S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S1 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S1 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S1 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S1 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S1) (assign (added_parameter_aut a6 categorical S1) (variable_value c1)))
	)

	(:action add_parameter_a3_S16_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a3 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a3 ?s2) (has_constraint a3 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S16 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S16 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S16 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S16 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S16) (assign (added_parameter_aut a3 integer S16) (variable_value v30)))
	)

	(:action add_parameter_a3_S16_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a3 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a3 ?s2) (has_constraint a3 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S16 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S16 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S16 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S16 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S16) (assign (added_parameter_aut a3 integer S16) (variable_value v0)))
	)

	(:action add_parameter_a15_sDEC1_2_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a15 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a15 ?s2) (has_constraint a15 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer sDEC1_2 ?s2)) (< (variable_value v5) (minority_constraint a15 integer sDEC1_2 ?s2)) (= (variable_value v5) (equality_constraint a15 integer sDEC1_2 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer sDEC1_2 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer sDEC1_2) (assign (added_parameter_aut a15 integer sDEC1_2) (variable_value v5)))
	)

	(:action add_parameter_a15_sDEC1_2_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a15 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a15 ?s2) (has_constraint a15 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer sDEC1_2 ?s2)) (< (variable_value v15) (minority_constraint a15 integer sDEC1_2 ?s2)) (= (variable_value v15) (equality_constraint a15 integer sDEC1_2 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer sDEC1_2 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer sDEC1_2) (assign (added_parameter_aut a15 integer sDEC1_2) (variable_value v15)))
	)

	(:action add_parameter_a15_sDEC1_2_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a15 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a15 ?s2) (has_constraint a15 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer sDEC1_2 ?s2)) (< (variable_value v30) (minority_constraint a15 integer sDEC1_2 ?s2)) (= (variable_value v30) (equality_constraint a15 integer sDEC1_2 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer sDEC1_2 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer sDEC1_2) (assign (added_parameter_aut a15 integer sDEC1_2) (variable_value v30)))
	)

	(:action add_parameter_a15_sDEC1_2_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a15 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a15 ?s2) (has_constraint a15 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer sDEC1_2 ?s2)) (< (variable_value v0) (minority_constraint a15 integer sDEC1_2 ?s2)) (= (variable_value v0) (equality_constraint a15 integer sDEC1_2 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer sDEC1_2 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer sDEC1_2) (assign (added_parameter_aut a15 integer sDEC1_2) (variable_value v0)))
	)

	(:action add_parameter_a16_S7_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a16 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a16 ?s2) (has_constraint a16 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S7 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S7 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S7 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S7 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S7) (assign (added_parameter_aut a16 integer S7) (variable_value v5)))
	)

	(:action add_parameter_a11_S16_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a11 categorical S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a11 ?s2) (has_constraint a11 categorical S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S16 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S16 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S16 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S16 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S16) (assign (added_parameter_aut a11 categorical S16) (variable_value c2)))
	)

	(:action add_parameter_a16_S7_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a16 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a16 ?s2) (has_constraint a16 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S7 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S7 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S7 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S7 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S7) (assign (added_parameter_aut a16 integer S7) (variable_value v15)))
	)

	(:action add_parameter_a12_S1_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a12 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a12 ?s2) (has_constraint a12 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S1 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S1 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S1 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S1 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S1) (assign (added_parameter_aut a12 integer S1) (variable_value v5)))
	)

	(:action add_parameter_a16_S7_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a16 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a16 ?s2) (has_constraint a16 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S7 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S7 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S7 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S7 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S7) (assign (added_parameter_aut a16 integer S7) (variable_value v0)))
	)

	(:action add_parameter_a1_S0_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a1 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a1 ?s2) (has_constraint a1 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S0 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S0 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S0 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S0 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S0) (assign (added_parameter_aut a1 integer S0) (variable_value v30)))
	)

	(:action add_parameter_a10_sDEC1_1_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a10 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a10 ?s2) (has_constraint a10 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer sDEC1_1 ?s2)) (< (variable_value v0) (minority_constraint a10 integer sDEC1_1 ?s2)) (= (variable_value v0) (equality_constraint a10 integer sDEC1_1 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer sDEC1_1 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer sDEC1_1) (assign (added_parameter_aut a10 integer sDEC1_1) (variable_value v0)))
	)

	(:action add_parameter_a10_sDEC1_1_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a10 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a10 ?s2) (has_constraint a10 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer sDEC1_1 ?s2)) (< (variable_value v30) (minority_constraint a10 integer sDEC1_1 ?s2)) (= (variable_value v30) (equality_constraint a10 integer sDEC1_1 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer sDEC1_1 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer sDEC1_1) (assign (added_parameter_aut a10 integer sDEC1_1) (variable_value v30)))
	)

	(:action add_parameter_a1_S0_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a1 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a1 ?s2) (has_constraint a1 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S0 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S0 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S0 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S0 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S0) (assign (added_parameter_aut a1 integer S0) (variable_value v15)))
	)

	(:action add_parameter_a1_S0_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a1 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a1 ?s2) (has_constraint a1 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S0 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S0 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S0 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S0 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S0) (assign (added_parameter_aut a1 integer S0) (variable_value v0)))
	)

	(:action add_parameter_a2_sDEC1_1_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a2 categorical sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a2 ?s2) (has_constraint a2 categorical sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical sDEC1_1 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical sDEC1_1 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical sDEC1_1 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical sDEC1_1 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical sDEC1_1) (assign (added_parameter_aut a2 categorical sDEC1_1) (variable_value c3)))
	)

	(:action add_parameter_a10_sDEC1_1_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a10 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a10 ?s2) (has_constraint a10 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer sDEC1_1 ?s2)) (< (variable_value v15) (minority_constraint a10 integer sDEC1_1 ?s2)) (= (variable_value v15) (equality_constraint a10 integer sDEC1_1 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer sDEC1_1 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer sDEC1_1) (assign (added_parameter_aut a10 integer sDEC1_1) (variable_value v15)))
	)

	(:action add_parameter_a1_S0_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a1 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a1 ?s2) (has_constraint a1 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S0 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S0 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S0 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S0 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S0) (assign (added_parameter_aut a1 integer S0) (variable_value v5)))
	)

	(:action add_parameter_a2_sDEC1_1_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a2 categorical sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a2 ?s2) (has_constraint a2 categorical sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical sDEC1_1 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical sDEC1_1 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical sDEC1_1 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical sDEC1_1 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical sDEC1_1) (assign (added_parameter_aut a2 categorical sDEC1_1) (variable_value c2)))
	)

	(:action add_parameter_a2_sDEC1_1_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a2 categorical sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a2 ?s2) (has_constraint a2 categorical sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical sDEC1_1 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical sDEC1_1 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical sDEC1_1 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical sDEC1_1 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical sDEC1_1) (assign (added_parameter_aut a2 categorical sDEC1_1) (variable_value c1)))
	)

	(:action add_parameter_a3_S13_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a3 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a3 ?s2) (has_constraint a3 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S13 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S13 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S13 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S13 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S13) (assign (added_parameter_aut a3 integer S13) (variable_value v30)))
	)

	(:action add_parameter_a16_S7_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a16 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a16 ?s2) (has_constraint a16 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S7 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S7 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S7 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S7 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S7) (assign (added_parameter_aut a16 integer S7) (variable_value v30)))
	)

	(:action add_parameter_a12_S1_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a12 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a12 ?s2) (has_constraint a12 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S1 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S1 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S1 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S1 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S1) (assign (added_parameter_aut a12 integer S1) (variable_value v0)))
	)

	(:action add_parameter_a12_S1_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a12 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a12 ?s2) (has_constraint a12 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S1 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S1 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S1 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S1 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S1) (assign (added_parameter_aut a12 integer S1) (variable_value v15)))
	)

	(:action add_parameter_a3_S13_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a3 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a3 ?s2) (has_constraint a3 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S13 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S13 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S13 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S13 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S13) (assign (added_parameter_aut a3 integer S13) (variable_value v0)))
	)

	(:action add_parameter_a12_S1_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a12 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a12 ?s2) (has_constraint a12 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S1 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S1 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S1 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S1 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S1) (assign (added_parameter_aut a12 integer S1) (variable_value v30)))
	)

	(:action add_parameter_a11_S16_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a11 categorical S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a11 ?s2) (has_constraint a11 categorical S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S16 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S16 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S16 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S16 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S16) (assign (added_parameter_aut a11 categorical S16) (variable_value c1)))
	)

	(:action add_parameter_a3_S13_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a3 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a3 ?s2) (has_constraint a3 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S13 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S13 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S13 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S13 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S13) (assign (added_parameter_aut a3 integer S13) (variable_value v5)))
	)

	(:action add_parameter_a3_S13_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a3 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a3 ?s2) (has_constraint a3 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S13 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S13 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S13 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S13 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S13) (assign (added_parameter_aut a3 integer S13) (variable_value v15)))
	)

	(:action add_parameter_a11_S16_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a11 categorical S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a11 ?s2) (has_constraint a11 categorical S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S16 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S16 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S16 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S16 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S16) (assign (added_parameter_aut a11 categorical S16) (variable_value c3)))
	)

	(:action add_parameter_a15_S10_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a15 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a15 ?s2) (has_constraint a15 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S10 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S10 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S10 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S10 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S10) (assign (added_parameter_aut a15 integer S10) (variable_value v5)))
	)

	(:action add_parameter_a19_S5_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a19 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a19 ?s2) (has_constraint a19 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S5 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S5 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S5 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S5 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S5) (assign (added_parameter_aut a19 integer S5) (variable_value v0)))
	)

	(:action add_parameter_a19_S5_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a19 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a19 ?s2) (has_constraint a19 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S5 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S5 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S5 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S5 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S5) (assign (added_parameter_aut a19 integer S5) (variable_value v15)))
	)

	(:action add_parameter_a19_S5_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a19 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a19 ?s2) (has_constraint a19 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S5 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S5 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S5 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S5 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S5) (assign (added_parameter_aut a19 integer S5) (variable_value v5)))
	)

	(:action add_parameter_a9_S5_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a9 categorical S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a9 ?s2) (has_constraint a9 categorical S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S5 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S5 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S5 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S5 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S5) (assign (added_parameter_aut a9 categorical S5) (variable_value c1)))
	)

	(:action add_parameter_a10_sDEC1_1_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a10 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a10 ?s2) (has_constraint a10 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer sDEC1_1 ?s2)) (< (variable_value v5) (minority_constraint a10 integer sDEC1_1 ?s2)) (= (variable_value v5) (equality_constraint a10 integer sDEC1_1 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer sDEC1_1 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer sDEC1_1) (assign (added_parameter_aut a10 integer sDEC1_1) (variable_value v5)))
	)

	(:action add_parameter_a19_S5_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a19 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a19 ?s2) (has_constraint a19 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S5 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S5 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S5 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S5 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S5) (assign (added_parameter_aut a19 integer S5) (variable_value v30)))
	)

	(:action add_parameter_a9_S5_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a9 categorical S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a9 ?s2) (has_constraint a9 categorical S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S5 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S5 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S5 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S5 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S5) (assign (added_parameter_aut a9 categorical S5) (variable_value c2)))
	)

	(:action add_parameter_a15_S10_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a15 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a15 ?s2) (has_constraint a15 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S10 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S10 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S10 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S10 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S10) (assign (added_parameter_aut a15 integer S10) (variable_value v0)))
	)

	(:action add_parameter_a9_S5_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a9 categorical S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a9 ?s2) (has_constraint a9 categorical S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S5 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S5 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S5 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S5 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S5) (assign (added_parameter_aut a9 categorical S5) (variable_value c3)))
	)

	(:action add_parameter_a15_S10_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a15 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a15 ?s2) (has_constraint a15 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S10 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S10 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S10 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S10 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S10) (assign (added_parameter_aut a15 integer S10) (variable_value v15)))
	)

	(:action add_parameter_a15_S10_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a15 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a15 ?s2) (has_constraint a15 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S10 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S10 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S10 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S10 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S10) (assign (added_parameter_aut a15 integer S10) (variable_value v30)))
	)

	(:action add_parameter_a3_sDEC1_2_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a3 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a3 ?s2) (has_constraint a3 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer sDEC1_2 ?s2)) (< (variable_value v0) (minority_constraint a3 integer sDEC1_2 ?s2)) (= (variable_value v0) (equality_constraint a3 integer sDEC1_2 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer sDEC1_2 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer sDEC1_2) (assign (added_parameter_aut a3 integer sDEC1_2) (variable_value v0)))
	)

	(:action add_parameter_a18_S6_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a18 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a18 ?s2) (has_constraint a18 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S6 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S6 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S6 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S6 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S6) (assign (added_parameter_aut a18 integer S6) (variable_value v0)))
	)

	(:action add_parameter_a3_sDEC1_2_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a3 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a3 ?s2) (has_constraint a3 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer sDEC1_2 ?s2)) (< (variable_value v15) (minority_constraint a3 integer sDEC1_2 ?s2)) (= (variable_value v15) (equality_constraint a3 integer sDEC1_2 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer sDEC1_2 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer sDEC1_2) (assign (added_parameter_aut a3 integer sDEC1_2) (variable_value v15)))
	)

	(:action add_parameter_a18_S6_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a18 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a18 ?s2) (has_constraint a18 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S6 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S6 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S6 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S6 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S6) (assign (added_parameter_aut a18 integer S6) (variable_value v15)))
	)

	(:action add_parameter_a11_S3_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a11 categorical S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a11 ?s2) (has_constraint a11 categorical S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S3 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S3 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S3 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S3 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S3) (assign (added_parameter_aut a11 categorical S3) (variable_value c1)))
	)

	(:action add_parameter_a3_sDEC1_2_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a3 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a3 ?s2) (has_constraint a3 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer sDEC1_2 ?s2)) (< (variable_value v30) (minority_constraint a3 integer sDEC1_2 ?s2)) (= (variable_value v30) (equality_constraint a3 integer sDEC1_2 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer sDEC1_2 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer sDEC1_2) (assign (added_parameter_aut a3 integer sDEC1_2) (variable_value v30)))
	)

	(:action add_parameter_a18_S6_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a18 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a18 ?s2) (has_constraint a18 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S6 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S6 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S6 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S6 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S6) (assign (added_parameter_aut a18 integer S6) (variable_value v5)))
	)

	(:action add_parameter_a11_S3_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a11 categorical S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a11 ?s2) (has_constraint a11 categorical S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S3 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S3 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S3 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S3 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S3) (assign (added_parameter_aut a11 categorical S3) (variable_value c3)))
	)

	(:action add_parameter_a3_sDEC1_2_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a3 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a3 ?s2) (has_constraint a3 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer sDEC1_2 ?s2)) (< (variable_value v5) (minority_constraint a3 integer sDEC1_2 ?s2)) (= (variable_value v5) (equality_constraint a3 integer sDEC1_2 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer sDEC1_2 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer sDEC1_2) (assign (added_parameter_aut a3 integer sDEC1_2) (variable_value v5)))
	)

	(:action add_parameter_a6_S11_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a6 categorical S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a6 ?s2) (has_constraint a6 categorical S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S11 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S11 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S11 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S11 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S11) (assign (added_parameter_aut a6 categorical S11) (variable_value c2)))
	)

	(:action add_parameter_a18_S6_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a18 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a18 ?s2) (has_constraint a18 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S6 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S6 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S6 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S6 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S6) (assign (added_parameter_aut a18 integer S6) (variable_value v30)))
	)

	(:action add_parameter_a1_S16_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a1 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a1 ?s2) (has_constraint a1 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S16 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S16 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S16 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S16 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S16) (assign (added_parameter_aut a1 integer S16) (variable_value v0)))
	)

	(:action add_parameter_a10_S14_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a10 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a10 ?s2) (has_constraint a10 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S14 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S14 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S14 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S14 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S14) (assign (added_parameter_aut a10 integer S14) (variable_value v15)))
	)

	(:action add_parameter_a1_S16_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a1 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a1 ?s2) (has_constraint a1 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S16 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S16 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S16 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S16 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S16) (assign (added_parameter_aut a1 integer S16) (variable_value v30)))
	)

	(:action add_parameter_a10_S14_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a10 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a10 ?s2) (has_constraint a10 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S14 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S14 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S14 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S14 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S14) (assign (added_parameter_aut a10 integer S14) (variable_value v0)))
	)

	(:action add_parameter_a6_S11_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a6 categorical S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a6 ?s2) (has_constraint a6 categorical S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S11 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S11 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S11 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S11 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S11) (assign (added_parameter_aut a6 categorical S11) (variable_value c3)))
	)

	(:action add_parameter_a2_S14_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a2 categorical S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a2 ?s2) (has_constraint a2 categorical S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S14 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S14 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S14 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S14 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S14) (assign (added_parameter_aut a2 categorical S14) (variable_value c3)))
	)

	(:action add_parameter_a10_S14_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a10 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a10 ?s2) (has_constraint a10 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S14 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S14 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S14 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S14 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S14) (assign (added_parameter_aut a10 integer S14) (variable_value v5)))
	)

	(:action add_parameter_a1_S16_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a1 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a1 ?s2) (has_constraint a1 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S16 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S16 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S16 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S16 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S16) (assign (added_parameter_aut a1 integer S16) (variable_value v15)))
	)

	(:action add_parameter_a2_S14_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a2 categorical S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a2 ?s2) (has_constraint a2 categorical S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S14 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S14 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S14 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S14 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S14) (assign (added_parameter_aut a2 categorical S14) (variable_value c2)))
	)

	(:action add_parameter_a1_S16_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a1 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a1 ?s2) (has_constraint a1 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S16 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S16 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S16 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S16 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S16) (assign (added_parameter_aut a1 integer S16) (variable_value v5)))
	)

	(:action add_parameter_a6_S11_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a6 categorical S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a6 ?s2) (has_constraint a6 categorical S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S11 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S11 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S11 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S11 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S11) (assign (added_parameter_aut a6 categorical S11) (variable_value c1)))
	)

	(:action add_parameter_a10_S14_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a10 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a10 ?s2) (has_constraint a10 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S14 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S14 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S14 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S14 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S14) (assign (added_parameter_aut a10 integer S14) (variable_value v30)))
	)

	(:action add_parameter_a2_S14_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a2 categorical S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a2 ?s2) (has_constraint a2 categorical S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S14 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S14 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S14 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S14 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S14) (assign (added_parameter_aut a2 categorical S14) (variable_value c1)))
	)

	(:action add_parameter_a11_S3_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a11 categorical S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a11 ?s2) (has_constraint a11 categorical S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S3 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S3 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S3 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S3 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S3) (assign (added_parameter_aut a11 categorical S3) (variable_value c2)))
	)

	(:action add_parameter_a10_S5_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a10 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a10 ?s2) (has_constraint a10 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S5 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S5 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S5 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S5 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S5) (assign (added_parameter_aut a10 integer S5) (variable_value v0)))
	)

	(:action add_parameter_a10_S5_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a10 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a10 ?s2) (has_constraint a10 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S5 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S5 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S5 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S5 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S5) (assign (added_parameter_aut a10 integer S5) (variable_value v30)))
	)

	(:action add_parameter_a9_S10_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a9 categorical S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a9 ?s2) (has_constraint a9 categorical S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S10 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S10 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S10 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S10 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S10) (assign (added_parameter_aut a9 categorical S10) (variable_value c3)))
	)

	(:action add_parameter_a2_S5_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a2 categorical S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a2 ?s2) (has_constraint a2 categorical S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S5 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S5 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S5 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S5 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S5) (assign (added_parameter_aut a2 categorical S5) (variable_value c2)))
	)

	(:action add_parameter_a6_sDEC1_1_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a6 categorical sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a6 ?s2) (has_constraint a6 categorical sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical sDEC1_1 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical sDEC1_1 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical sDEC1_1 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical sDEC1_1 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical sDEC1_1) (assign (added_parameter_aut a6 categorical sDEC1_1) (variable_value c1)))
	)

	(:action add_parameter_a10_S5_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a10 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a10 ?s2) (has_constraint a10 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S5 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S5 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S5 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S5 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S5) (assign (added_parameter_aut a10 integer S5) (variable_value v15)))
	)

	(:action add_parameter_a6_sDEC1_1_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a6 categorical sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a6 ?s2) (has_constraint a6 categorical sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical sDEC1_1 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical sDEC1_1 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical sDEC1_1 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical sDEC1_1 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical sDEC1_1) (assign (added_parameter_aut a6 categorical sDEC1_1) (variable_value c2)))
	)

	(:action add_parameter_a10_S5_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a10 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a10 ?s2) (has_constraint a10 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S5 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S5 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S5 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S5 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S5) (assign (added_parameter_aut a10 integer S5) (variable_value v5)))
	)

	(:action add_parameter_a2_S5_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a2 categorical S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a2 ?s2) (has_constraint a2 categorical S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S5 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S5 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S5 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S5 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S5) (assign (added_parameter_aut a2 categorical S5) (variable_value c3)))
	)

	(:action add_parameter_a6_sDEC1_1_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a6 categorical sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a6 ?s2) (has_constraint a6 categorical sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical sDEC1_1 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical sDEC1_1 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical sDEC1_1 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical sDEC1_1 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical sDEC1_1) (assign (added_parameter_aut a6 categorical sDEC1_1) (variable_value c3)))
	)

	(:action add_parameter_a1_S7_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a1 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a1 ?s2) (has_constraint a1 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S7 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S7 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S7 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S7 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S7) (assign (added_parameter_aut a1 integer S7) (variable_value v30)))
	)

	(:action add_parameter_a12_S18_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a12 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a12 ?s2) (has_constraint a12 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S18 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S18 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S18 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S18 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S18) (assign (added_parameter_aut a12 integer S18) (variable_value v30)))
	)

	(:action add_parameter_a1_S7_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a1 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a1 ?s2) (has_constraint a1 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S7 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S7 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S7 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S7 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S7) (assign (added_parameter_aut a1 integer S7) (variable_value v15)))
	)

	(:action add_parameter_a1_S7_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a1 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a1 ?s2) (has_constraint a1 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S7 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S7 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S7 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S7 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S7) (assign (added_parameter_aut a1 integer S7) (variable_value v0)))
	)

	(:action add_parameter_a2_S5_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a2 categorical S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a2 ?s2) (has_constraint a2 categorical S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S5 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S5 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S5 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S5 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S5) (assign (added_parameter_aut a2 categorical S5) (variable_value c1)))
	)

	(:action add_parameter_a1_S7_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a1 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a1 ?s2) (has_constraint a1 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S7 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S7 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S7 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S7 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S7) (assign (added_parameter_aut a1 integer S7) (variable_value v5)))
	)

	(:action add_parameter_a16_S1_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a16 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a16 ?s2) (has_constraint a16 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S1 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S1 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S1 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S1 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S1) (assign (added_parameter_aut a16 integer S1) (variable_value v5)))
	)

	(:action add_parameter_a12_S18_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a12 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a12 ?s2) (has_constraint a12 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S18 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S18 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S18 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S18 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S18) (assign (added_parameter_aut a12 integer S18) (variable_value v15)))
	)

	(:action add_parameter_a16_S1_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a16 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a16 ?s2) (has_constraint a16 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S1 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S1 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S1 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S1 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S1) (assign (added_parameter_aut a16 integer S1) (variable_value v15)))
	)

	(:action add_parameter_a16_S1_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a16 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a16 ?s2) (has_constraint a16 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S1 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S1 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S1 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S1 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S1) (assign (added_parameter_aut a16 integer S1) (variable_value v0)))
	)

	(:action add_parameter_a12_S18_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a12 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a12 ?s2) (has_constraint a12 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S18 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S18 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S18 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S18 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S18) (assign (added_parameter_aut a12 integer S18) (variable_value v0)))
	)

	(:action add_parameter_a16_S1_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a16 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a16 ?s2) (has_constraint a16 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S1 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S1 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S1 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S1 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S1) (assign (added_parameter_aut a16 integer S1) (variable_value v30)))
	)

	(:action add_parameter_a12_S18_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a12 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a12 ?s2) (has_constraint a12 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S18 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S18 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S18 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S18 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S18) (assign (added_parameter_aut a12 integer S18) (variable_value v5)))
	)

	(:action add_parameter_a6_S14_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a6 categorical S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a6 ?s2) (has_constraint a6 categorical S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S14 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S14 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S14 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S14 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S14) (assign (added_parameter_aut a6 categorical S14) (variable_value c3)))
	)

	(:action skip-unused_t0_a5_t1
		:parameters ()
		:precondition (and (cur_t_state t0) (trace t0 a5 t1) (not (recovery_finished)) (not (exists (?s1 - automaton_state ?s2 - automaton_state) (and (automaton ?s1 a5 ?s2) (not (failure_state ?s2)) ) )) )
		:effect (and (not (cur_t_state t0)) (cur_t_state t1) (when (final_t_state t1) (recovery_finished)))
	)

	(:action add_parameter_a15_S16_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a15 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a15 ?s2) (has_constraint a15 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S16 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S16 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S16 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S16 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S16) (assign (added_parameter_aut a15 integer S16) (variable_value v30)))
	)

	(:action add_parameter_a19_S10_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a19 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a19 ?s2) (has_constraint a19 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S10 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S10 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S10 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S10 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S10) (assign (added_parameter_aut a19 integer S10) (variable_value v30)))
	)

	(:action add_parameter_a19_S10_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a19 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a19 ?s2) (has_constraint a19 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S10 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S10 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S10 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S10 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S10) (assign (added_parameter_aut a19 integer S10) (variable_value v0)))
	)

	(:action add_parameter_a19_S10_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a19 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a19 ?s2) (has_constraint a19 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S10 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S10 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S10 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S10 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S10) (assign (added_parameter_aut a19 integer S10) (variable_value v15)))
	)

	(:action add_parameter_a19_S10_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a19 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a19 ?s2) (has_constraint a19 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S10 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S10 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S10 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S10 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S10) (assign (added_parameter_aut a19 integer S10) (variable_value v5)))
	)

	(:action add_parameter_a9_S10_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a9 categorical S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a9 ?s2) (has_constraint a9 categorical S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S10 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S10 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S10 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S10 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S10) (assign (added_parameter_aut a9 categorical S10) (variable_value c2)))
	)

	(:action add_parameter_a15_S16_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a15 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a15 ?s2) (has_constraint a15 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S16 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S16 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S16 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S16 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S16) (assign (added_parameter_aut a15 integer S16) (variable_value v5)))
	)

	(:action add_parameter_a15_S16_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a15 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a15 ?s2) (has_constraint a15 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S16 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S16 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S16 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S16 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S16) (assign (added_parameter_aut a15 integer S16) (variable_value v0)))
	)

	(:action add_parameter_a9_S10_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a9 categorical S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a9 ?s2) (has_constraint a9 categorical S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S10 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S10 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S10 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S10 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S10) (assign (added_parameter_aut a9 categorical S10) (variable_value c1)))
	)

	(:action add_parameter_a15_S16_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a15 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a15 ?s2) (has_constraint a15 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S16 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S16 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S16 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S16 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S16) (assign (added_parameter_aut a15 integer S16) (variable_value v15)))
	)

	(:action add_parameter_a11_S17_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a11 categorical S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a11 ?s2) (has_constraint a11 categorical S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S17 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S17 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S17 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S17 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S17) (assign (added_parameter_aut a11 categorical S17) (variable_value c3)))
	)

	(:action add_parameter_a12_S4_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a12 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a12 ?s2) (has_constraint a12 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S4 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S4 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S4 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S4 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S4) (assign (added_parameter_aut a12 integer S4) (variable_value v30)))
	)

	(:action add_parameter_a12_S4_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a12 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a12 ?s2) (has_constraint a12 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S4 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S4 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S4 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S4 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S4) (assign (added_parameter_aut a12 integer S4) (variable_value v0)))
	)

	(:action add_parameter_a11_S17_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a11 categorical S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a11 ?s2) (has_constraint a11 categorical S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S17 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S17 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S17 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S17 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S17) (assign (added_parameter_aut a11 categorical S17) (variable_value c1)))
	)

	(:action add_parameter_a12_S4_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a12 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a12 ?s2) (has_constraint a12 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S4 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S4 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S4 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S4 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S4) (assign (added_parameter_aut a12 integer S4) (variable_value v5)))
	)

	(:action add_parameter_a12_S4_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a12 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a12 ?s2) (has_constraint a12 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S4 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S4 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S4 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S4 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S4) (assign (added_parameter_aut a12 integer S4) (variable_value v15)))
	)

	(:action add_parameter_a11_S17_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a11 categorical S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a11 ?s2) (has_constraint a11 categorical S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S17 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S17 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S17 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S17 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S17) (assign (added_parameter_aut a11 categorical S17) (variable_value c2)))
	)

	(:action add_parameter_a3_S6_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a3 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a3 ?s2) (has_constraint a3 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S6 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S6 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S6 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S6 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S6) (assign (added_parameter_aut a3 integer S6) (variable_value v30)))
	)

	(:action add_parameter_a18_S11_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a18 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a18 ?s2) (has_constraint a18 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S11 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S11 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S11 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S11 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S11) (assign (added_parameter_aut a18 integer S11) (variable_value v30)))
	)

	(:action add_parameter_a18_S11_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a18 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a18 ?s2) (has_constraint a18 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S11 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S11 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S11 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S11 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S11) (assign (added_parameter_aut a18 integer S11) (variable_value v0)))
	)

	(:action add_parameter_a18_S11_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a18 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a18 ?s2) (has_constraint a18 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S11 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S11 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S11 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S11 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S11) (assign (added_parameter_aut a18 integer S11) (variable_value v15)))
	)

	(:action add_parameter_a18_S11_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a18 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a18 ?s2) (has_constraint a18 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S11 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S11 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S11 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S11 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S11) (assign (added_parameter_aut a18 integer S11) (variable_value v5)))
	)

	(:action add_parameter_a3_S6_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a3 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a3 ?s2) (has_constraint a3 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S6 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S6 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S6 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S6 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S6) (assign (added_parameter_aut a3 integer S6) (variable_value v5)))
	)

	(:action add_parameter_a3_S6_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a3 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a3 ?s2) (has_constraint a3 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S6 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S6 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S6 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S6 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S6) (assign (added_parameter_aut a3 integer S6) (variable_value v0)))
	)

	(:action add_parameter_a3_S6_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a3 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a3 ?s2) (has_constraint a3 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S6 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S6 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S6 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S6 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S6) (assign (added_parameter_aut a3 integer S6) (variable_value v15)))
	)

	(:action add_parameter_a6_S14_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a6 categorical S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a6 ?s2) (has_constraint a6 categorical S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S14 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S14 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S14 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S14 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S14) (assign (added_parameter_aut a6 categorical S14) (variable_value c2)))
	)

	(:action add_parameter_a6_S14_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a6 categorical S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a6 ?s2) (has_constraint a6 categorical S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S14 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S14 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S14 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S14 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S14) (assign (added_parameter_aut a6 categorical S14) (variable_value c1)))
	)

	(:action add_parameter_a15_S3_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a15 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a15 ?s2) (has_constraint a15 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S3 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S3 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S3 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S3 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S3) (assign (added_parameter_aut a15 integer S3) (variable_value v30)))
	)

	(:action add_parameter_a15_S3_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a15 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a15 ?s2) (has_constraint a15 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S3 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S3 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S3 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S3 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S3) (assign (added_parameter_aut a15 integer S3) (variable_value v0)))
	)

	(:action add_parameter_a15_S3_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a15 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a15 ?s2) (has_constraint a15 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S3 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S3 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S3 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S3 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S3) (assign (added_parameter_aut a15 integer S3) (variable_value v5)))
	)

	(:action add_parameter_a15_S3_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a15 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a15 ?s2) (has_constraint a15 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S3 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S3 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S3 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S3 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S3) (assign (added_parameter_aut a15 integer S3) (variable_value v15)))
	)

	(:action add_parameter_a1_S6_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a1 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a1 ?s2) (has_constraint a1 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S6 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S6 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S6 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S6 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S6) (assign (added_parameter_aut a1 integer S6) (variable_value v5)))
	)

	(:action add_parameter_a2_S4_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a2 categorical S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a2 ?s2) (has_constraint a2 categorical S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S4 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S4 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S4 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S4 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S4) (assign (added_parameter_aut a2 categorical S4) (variable_value c2)))
	)

	(:action add_parameter_a10_S4_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a10 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a10 ?s2) (has_constraint a10 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S4 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S4 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S4 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S4 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S4) (assign (added_parameter_aut a10 integer S4) (variable_value v5)))
	)

	(:action add_parameter_a2_S4_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a2 categorical S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a2 ?s2) (has_constraint a2 categorical S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S4 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S4 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S4 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S4 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S4) (assign (added_parameter_aut a2 categorical S4) (variable_value c1)))
	)

	(:action add_parameter_a10_S4_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a10 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a10 ?s2) (has_constraint a10 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S4 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S4 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S4 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S4 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S4) (assign (added_parameter_aut a10 integer S4) (variable_value v0)))
	)

	(:action add_parameter_a10_S4_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a10 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a10 ?s2) (has_constraint a10 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S4 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S4 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S4 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S4 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S4) (assign (added_parameter_aut a10 integer S4) (variable_value v30)))
	)

	(:action add_parameter_a10_S4_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a10 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a10 ?s2) (has_constraint a10 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S4 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S4 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S4 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S4 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S4) (assign (added_parameter_aut a10 integer S4) (variable_value v15)))
	)

	(:action add_parameter_a1_S6_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a1 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a1 ?s2) (has_constraint a1 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S6 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S6 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S6 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S6 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S6) (assign (added_parameter_aut a1 integer S6) (variable_value v30)))
	)

	(:action add_parameter_a1_S6_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a1 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a1 ?s2) (has_constraint a1 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S6 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S6 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S6 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S6 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S6) (assign (added_parameter_aut a1 integer S6) (variable_value v15)))
	)

	(:action add_parameter_a1_S6_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a1 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a1 ?s2) (has_constraint a1 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S6 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S6 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S6 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S6 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S6) (assign (added_parameter_aut a1 integer S6) (variable_value v0)))
	)

	(:action add_parameter_a2_S4_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a2 categorical S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a2 ?s2) (has_constraint a2 categorical S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S4 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S4 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S4 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S4 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S4) (assign (added_parameter_aut a2 categorical S4) (variable_value c3)))
	)

	(:action add_parameter_a16_S11_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a16 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a16 ?s2) (has_constraint a16 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S11 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S11 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S11 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S11 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S11) (assign (added_parameter_aut a16 integer S11) (variable_value v5)))
	)

	(:action add_parameter_a3_S16_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a3 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a3 ?s2) (has_constraint a3 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S16 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S16 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S16 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S16 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S16) (assign (added_parameter_aut a3 integer S16) (variable_value v5)))
	)

	(:action add_parameter_a12_S14_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a12 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a12 ?s2) (has_constraint a12 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S14 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S14 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S14 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S14 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S14) (assign (added_parameter_aut a12 integer S14) (variable_value v5)))
	)

	(:action add_parameter_a3_S16_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a3 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a3 ?s2) (has_constraint a3 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S16 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S16 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S16 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S16 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S16) (assign (added_parameter_aut a3 integer S16) (variable_value v15)))
	)

	(:action add_parameter_a16_S11_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a16 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a16 ?s2) (has_constraint a16 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S11 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S11 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S11 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S11 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S11) (assign (added_parameter_aut a16 integer S11) (variable_value v15)))
	)

	(:action add_parameter_a16_S11_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a16 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a16 ?s2) (has_constraint a16 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S11 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S11 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S11 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S11 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S11) (assign (added_parameter_aut a16 integer S11) (variable_value v0)))
	)

	(:action add_parameter_a12_S14_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a12 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a12 ?s2) (has_constraint a12 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S14 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S14 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S14 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S14 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S14) (assign (added_parameter_aut a12 integer S14) (variable_value v30)))
	)

	(:action add_parameter_a16_S11_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a16 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a16 ?s2) (has_constraint a16 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S11 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S11 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S11 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S11 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S11) (assign (added_parameter_aut a16 integer S11) (variable_value v30)))
	)

	(:action add_parameter_a12_S14_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a12 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a12 ?s2) (has_constraint a12 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S14 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S14 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S14 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S14 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S14) (assign (added_parameter_aut a12 integer S14) (variable_value v15)))
	)

	(:action add_parameter_a12_S14_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a12 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a12 ?s2) (has_constraint a12 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S14 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S14 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S14 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S14 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S14) (assign (added_parameter_aut a12 integer S14) (variable_value v0)))
	)

	(:action add_parameter_a6_S15_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a6 categorical S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a6 ?s2) (has_constraint a6 categorical S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S15 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S15 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S15 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S15 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S15) (assign (added_parameter_aut a6 categorical S15) (variable_value c3)))
	)

	(:action add_parameter_a19_S9_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a19 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a19 ?s2) (has_constraint a19 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S9 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S9 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S9 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S9 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S9) (assign (added_parameter_aut a19 integer S9) (variable_value v30)))
	)

	(:action add_parameter_a19_S9_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a19 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a19 ?s2) (has_constraint a19 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S9 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S9 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S9 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S9 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S9) (assign (added_parameter_aut a19 integer S9) (variable_value v0)))
	)

	(:action add_parameter_a19_S9_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a19 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a19 ?s2) (has_constraint a19 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S9 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S9 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S9 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S9 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S9) (assign (added_parameter_aut a19 integer S9) (variable_value v15)))
	)

	(:action validate-failure_pn
		:parameters ()
		:precondition (and (not (after_sync)) (not (after_add)) (not (after_add_check)) (exists (?s1 - automaton_state) (and (cur_s_state ?s1) (associated ?s1 pn) (not (goal_state ?s1))  ) ) )
		:effect (and (forall (?s1 - automaton_state) (when (and (cur_s_state ?s1) (associated ?s1 pn) (not (goal_state ?s1)) ) (violated pn)) ) )
	)

	(:action add_parameter_a19_S9_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a19 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a19 ?s2) (has_constraint a19 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S9 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S9 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S9 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S9 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S9) (assign (added_parameter_aut a19 integer S9) (variable_value v5)))
	)

	(:action validate-failure_Response_ActivityG_ActivityP
		:parameters ()
		:precondition (and (not (after_sync)) (not (after_add)) (not (after_add_check)) (exists (?s1 - automaton_state) (and (cur_s_state ?s1) (associated ?s1 Response_ActivityG_ActivityP) (not (goal_state ?s1))  ) ) )
		:effect (and (forall (?s1 - automaton_state) (when (and (cur_s_state ?s1) (associated ?s1 Response_ActivityG_ActivityP) (not (goal_state ?s1)) ) (violated Response_ActivityG_ActivityP)) ) )
	)

	(:action add_parameter_a9_S9_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a9 categorical S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a9 ?s2) (has_constraint a9 categorical S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S9 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S9 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S9 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S9 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S9) (assign (added_parameter_aut a9 categorical S9) (variable_value c1)))
	)

	(:action add_parameter_a9_S9_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a9 categorical S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a9 ?s2) (has_constraint a9 categorical S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S9 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S9 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S9 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S9 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S9) (assign (added_parameter_aut a9 categorical S9) (variable_value c2)))
	)

	(:action add_parameter_a15_S12_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a15 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a15 ?s2) (has_constraint a15 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S12 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S12 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S12 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S12 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S12) (assign (added_parameter_aut a15 integer S12) (variable_value v5)))
	)

	(:action add_parameter_a15_S12_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a15 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a15 ?s2) (has_constraint a15 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S12 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S12 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S12 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S12 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S12) (assign (added_parameter_aut a15 integer S12) (variable_value v0)))
	)

	(:action add_parameter_a9_S9_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a9 categorical S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a9 ?s2) (has_constraint a9 categorical S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S9 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S9 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S9 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S9 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S9) (assign (added_parameter_aut a9 categorical S9) (variable_value c3)))
	)

	(:action add_parameter_a15_S12_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a15 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a15 ?s2) (has_constraint a15 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S12 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S12 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S12 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S12 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S12) (assign (added_parameter_aut a15 integer S12) (variable_value v15)))
	)

	(:action add_parameter_a15_S12_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a15 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a15 ?s2) (has_constraint a15 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S12 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S12 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S12 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S12 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S12) (assign (added_parameter_aut a15 integer S12) (variable_value v30)))
	)

	(:action add_parameter_a11_S7_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a11 categorical S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a11 ?s2) (has_constraint a11 categorical S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S7 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S7 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S7 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S7 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S7) (assign (added_parameter_aut a11 categorical S7) (variable_value c3)))
	)

	(:action add_parameter_a11_S7_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a11 categorical S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a11 ?s2) (has_constraint a11 categorical S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S7 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S7 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S7 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S7 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S7) (assign (added_parameter_aut a11 categorical S7) (variable_value c2)))
	)

	(:action add_parameter_a12_S2_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a12 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a12 ?s2) (has_constraint a12 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S2 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S2 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S2 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S2 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S2) (assign (added_parameter_aut a12 integer S2) (variable_value v5)))
	)

	(:action add_parameter_a3_S3_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a3 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a3 ?s2) (has_constraint a3 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S3 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S3 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S3 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S3 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S3) (assign (added_parameter_aut a3 integer S3) (variable_value v5)))
	)

	(:action add_parameter_a12_S2_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a12 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a12 ?s2) (has_constraint a12 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S2 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S2 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S2 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S2 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S2) (assign (added_parameter_aut a12 integer S2) (variable_value v15)))
	)

	(:action add_parameter_a12_S2_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a12 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a12 ?s2) (has_constraint a12 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S2 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S2 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S2 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S2 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S2) (assign (added_parameter_aut a12 integer S2) (variable_value v30)))
	)

	(:action add_parameter_a11_S7_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a11 categorical S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a11 ?s2) (has_constraint a11 categorical S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S7 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S7 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S7 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S7 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S7) (assign (added_parameter_aut a11 categorical S7) (variable_value c1)))
	)

	(:action add_parameter_a12_S2_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a12 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a12 ?s2) (has_constraint a12 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S2 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S2 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S2 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S2 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S2) (assign (added_parameter_aut a12 integer S2) (variable_value v0)))
	)

	(:action add_parameter_a18_S17_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a18 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a18 ?s2) (has_constraint a18 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S17 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S17 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S17 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S17 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S17) (assign (added_parameter_aut a18 integer S17) (variable_value v30)))
	)

	(:action add_parameter_a3_S3_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a3 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a3 ?s2) (has_constraint a3 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S3 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S3 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S3 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S3 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S3) (assign (added_parameter_aut a3 integer S3) (variable_value v0)))
	)

	(:action add_parameter_a18_S17_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a18 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a18 ?s2) (has_constraint a18 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S17 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S17 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S17 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S17 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S17) (assign (added_parameter_aut a18 integer S17) (variable_value v0)))
	)

	(:action add_parameter_a3_S3_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a3 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a3 ?s2) (has_constraint a3 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S3 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S3 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S3 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S3 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S3) (assign (added_parameter_aut a3 integer S3) (variable_value v15)))
	)

	(:action add_parameter_a18_S17_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a18 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a18 ?s2) (has_constraint a18 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S17 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S17 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S17 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S17 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S17) (assign (added_parameter_aut a18 integer S17) (variable_value v15)))
	)

	(:action add_parameter_a3_S3_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a3 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a3 ?s2) (has_constraint a3 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S3 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S3 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S3 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S3 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S3) (assign (added_parameter_aut a3 integer S3) (variable_value v30)))
	)

	(:action add_parameter_a18_S17_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a18 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a18 ?s2) (has_constraint a18 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S17 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S17 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S17 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S17 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S17) (assign (added_parameter_aut a18 integer S17) (variable_value v5)))
	)

	(:action add_parameter_a6_S15_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a6 categorical S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a6 ?s2) (has_constraint a6 categorical S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S15 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S15 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S15 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S15 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S15) (assign (added_parameter_aut a6 categorical S15) (variable_value c1)))
	)

	(:action add_parameter_a6_S15_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a6 categorical S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a6 ?s2) (has_constraint a6 categorical S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S15 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S15 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S15 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S15 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S15) (assign (added_parameter_aut a6 categorical S15) (variable_value c2)))
	)

	(:action add_parameter_a15_S0_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a15 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a15 ?s2) (has_constraint a15 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S0 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S0 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S0 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S0 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S0) (assign (added_parameter_aut a15 integer S0) (variable_value v5)))
	)

	(:action add_parameter_a15_S0_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a15 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a15 ?s2) (has_constraint a15 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S0 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S0 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S0 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S0 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S0) (assign (added_parameter_aut a15 integer S0) (variable_value v15)))
	)

	(:action add_parameter_a15_S0_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a15 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a15 ?s2) (has_constraint a15 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S0 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S0 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S0 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S0 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S0) (assign (added_parameter_aut a15 integer S0) (variable_value v30)))
	)

	(:action add_parameter_a15_S0_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a15 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a15 ?s2) (has_constraint a15 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S0 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S0 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S0 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S0 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S0) (assign (added_parameter_aut a15 integer S0) (variable_value v0)))
	)

	(:action add_parameter_a10_S9_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a10 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a10 ?s2) (has_constraint a10 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S9 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S9 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S9 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S9 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S9) (assign (added_parameter_aut a10 integer S9) (variable_value v15)))
	)

	(:action add_parameter_a9_S12_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a9 categorical S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a9 ?s2) (has_constraint a9 categorical S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S12 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S12 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S12 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S12 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S12) (assign (added_parameter_aut a9 categorical S12) (variable_value c1)))
	)

	(:action add_parameter_a10_S9_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a10 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a10 ?s2) (has_constraint a10 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S9 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S9 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S9 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S9 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S9) (assign (added_parameter_aut a10 integer S9) (variable_value v5)))
	)

	(:action add_parameter_a10_S9_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a10 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a10 ?s2) (has_constraint a10 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S9 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S9 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S9 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S9 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S9) (assign (added_parameter_aut a10 integer S9) (variable_value v0)))
	)

	(:action add_parameter_a10_S9_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a10 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a10 ?s2) (has_constraint a10 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S9 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S9 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S9 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S9 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S9) (assign (added_parameter_aut a10 integer S9) (variable_value v30)))
	)

	(:action add_parameter_a9_S12_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a9 categorical S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a9 ?s2) (has_constraint a9 categorical S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S12 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S12 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S12 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S12 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S12) (assign (added_parameter_aut a9 categorical S12) (variable_value c3)))
	)

	(:action add_parameter_a1_S11_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a1 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a1 ?s2) (has_constraint a1 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S11 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S11 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S11 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S11 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S11) (assign (added_parameter_aut a1 integer S11) (variable_value v15)))
	)

	(:action add_parameter_a16_S14_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a16 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a16 ?s2) (has_constraint a16 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S14 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S14 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S14 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S14 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S14) (assign (added_parameter_aut a16 integer S14) (variable_value v15)))
	)

	(:action add_parameter_a1_S11_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a1 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a1 ?s2) (has_constraint a1 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S11 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S11 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S11 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S11 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S11) (assign (added_parameter_aut a1 integer S11) (variable_value v0)))
	)

	(:action add_parameter_a2_S9_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a2 categorical S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a2 ?s2) (has_constraint a2 categorical S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S9 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S9 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S9 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S9 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S9) (assign (added_parameter_aut a2 categorical S9) (variable_value c1)))
	)

	(:action add_parameter_a6_S4_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a6 categorical S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a6 ?s2) (has_constraint a6 categorical S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S4 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S4 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S4 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S4 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S4) (assign (added_parameter_aut a6 categorical S4) (variable_value c1)))
	)

	(:action add_parameter_a16_S14_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a16 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a16 ?s2) (has_constraint a16 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S14 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S14 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S14 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S14 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S14) (assign (added_parameter_aut a16 integer S14) (variable_value v0)))
	)

	(:action add_parameter_a1_S11_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a1 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a1 ?s2) (has_constraint a1 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S11 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S11 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S11 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S11 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S11) (assign (added_parameter_aut a1 integer S11) (variable_value v5)))
	)

	(:action add_parameter_a16_S14_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a16 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a16 ?s2) (has_constraint a16 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S14 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S14 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S14 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S14 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S14) (assign (added_parameter_aut a16 integer S14) (variable_value v30)))
	)

	(:action add_parameter_a6_S4_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a6 categorical S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a6 ?s2) (has_constraint a6 categorical S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S4 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S4 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S4 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S4 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S4) (assign (added_parameter_aut a6 categorical S4) (variable_value c2)))
	)

	(:action add_parameter_a6_S4_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a6 categorical S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a6 ?s2) (has_constraint a6 categorical S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S4 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S4 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S4 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S4 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S4) (assign (added_parameter_aut a6 categorical S4) (variable_value c3)))
	)

	(:action add_parameter_a2_S9_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a2 categorical S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a2 ?s2) (has_constraint a2 categorical S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S9 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S9 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S9 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S9 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S9) (assign (added_parameter_aut a2 categorical S9) (variable_value c2)))
	)

	(:action add_parameter_a2_S9_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a2 categorical S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a2 ?s2) (has_constraint a2 categorical S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S9 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S9 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S9 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S9 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S9) (assign (added_parameter_aut a2 categorical S9) (variable_value c3)))
	)

	(:action add_parameter_a1_S11_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a1 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a1 ?s2) (has_constraint a1 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S11 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S11 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S11 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S11 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S11) (assign (added_parameter_aut a1 integer S11) (variable_value v30)))
	)

	(:action add_parameter_a16_S14_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a16 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a16 ?s2) (has_constraint a16 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S14 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S14 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S14 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S14 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S14) (assign (added_parameter_aut a16 integer S14) (variable_value v5)))
	)

	(:action add_parameter_a19_S12_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a19 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a19 ?s2) (has_constraint a19 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S12 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S12 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S12 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S12 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S12) (assign (added_parameter_aut a19 integer S12) (variable_value v5)))
	)

	(:action add_parameter_a19_S12_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a19 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a19 ?s2) (has_constraint a19 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S12 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S12 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S12 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S12 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S12) (assign (added_parameter_aut a19 integer S12) (variable_value v30)))
	)

	(:action add_parameter_a9_S12_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a9 categorical S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a9 ?s2) (has_constraint a9 categorical S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S12 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S12 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S12 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S12 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S12) (assign (added_parameter_aut a9 categorical S12) (variable_value c2)))
	)

	(:action add_parameter_a19_S12_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a19 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a19 ?s2) (has_constraint a19 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S12 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S12 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S12 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S12 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S12) (assign (added_parameter_aut a19 integer S12) (variable_value v0)))
	)

	(:action add_parameter_a19_S12_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a19 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a19 ?s2) (has_constraint a19 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S12 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S12 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S12 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S12 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S12) (assign (added_parameter_aut a19 integer S12) (variable_value v15)))
	)

	(:action add_parameter_a16_S2_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a16 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a16 ?s2) (has_constraint a16 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S2 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S2 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S2 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S2 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S2) (assign (added_parameter_aut a16 integer S2) (variable_value v5)))
	)

	(:action add_parameter_a11_S1_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a11 categorical S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a11 ?s2) (has_constraint a11 categorical S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S1 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S1 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S1 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S1 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S1) (assign (added_parameter_aut a11 categorical S1) (variable_value c1)))
	)

	(:action add_parameter_a12_S8_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a12 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a12 ?s2) (has_constraint a12 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S8 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S8 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S8 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S8 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S8) (assign (added_parameter_aut a12 integer S8) (variable_value v5)))
	)

	(:action add_parameter_a12_S8_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a12 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a12 ?s2) (has_constraint a12 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S8 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S8 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S8 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S8 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S8) (assign (added_parameter_aut a12 integer S8) (variable_value v15)))
	)

	(:action add_parameter_a11_S1_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a11 categorical S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a11 ?s2) (has_constraint a11 categorical S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S1 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S1 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S1 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S1 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S1) (assign (added_parameter_aut a11 categorical S1) (variable_value c2)))
	)

	(:action add_parameter_a11_S1_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a11 categorical S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a11 ?s2) (has_constraint a11 categorical S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S1 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S1 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S1 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S1 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S1) (assign (added_parameter_aut a11 categorical S1) (variable_value c3)))
	)

	(:action add_parameter_a12_S8_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a12 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a12 ?s2) (has_constraint a12 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S8 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S8 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S8 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S8 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S8) (assign (added_parameter_aut a12 integer S8) (variable_value v30)))
	)

	(:action add_parameter_a12_S8_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a12 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a12 ?s2) (has_constraint a12 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S8 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S8 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S8 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S8 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S8) (assign (added_parameter_aut a12 integer S8) (variable_value v0)))
	)

	(:action add_parameter_a16_S2_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a16 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a16 ?s2) (has_constraint a16 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S2 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S2 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S2 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S2 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S2) (assign (added_parameter_aut a16 integer S2) (variable_value v30)))
	)

	(:action add_parameter_a16_S2_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a16 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a16 ?s2) (has_constraint a16 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S2 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S2 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S2 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S2 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S2) (assign (added_parameter_aut a16 integer S2) (variable_value v0)))
	)

	(:action sync-actions_t1_t2_a0
		:parameters ()
		:precondition (and (not (after_add)) (not (failure)) (not (after_add_check)) (not (complete_sync a0)) (after_sync) (cur_t_state t1) (trace t1 a0 t2) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (automaton ?s1 a0 ?s2) ) ) )
		:effect (and (increase (total_cost) 0) (not (cur_t_state t1)) (cur_t_state t2) (when (final_t_state t2) (recovery_finished)) (not (after_sync)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (not (invalid ?s1 a0 ?s2)) (automaton ?s1 a0 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) )) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a0 ?s2)) (automaton ?s1 a0 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (invalid ?s1 a0 ?s2) (automaton ?s1 a0 ?s2) ) (not (invalid ?s1 a0 ?s2)) ) ) )
	)

	(:action add_parameter_a16_S2_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a16 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a16 ?s2) (has_constraint a16 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S2 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S2 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S2 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S2 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S2) (assign (added_parameter_aut a16 integer S2) (variable_value v15)))
	)

	(:action add_parameter_a18_S15_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a18 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a18 ?s2) (has_constraint a18 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S15 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S15 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S15 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S15 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S15) (assign (added_parameter_aut a18 integer S15) (variable_value v5)))
	)

	(:action add_parameter_a3_S17_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a3 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a3 ?s2) (has_constraint a3 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S17 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S17 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S17 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S17 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S17) (assign (added_parameter_aut a3 integer S17) (variable_value v5)))
	)

	(:action add_parameter_a3_S17_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a3 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a3 ?s2) (has_constraint a3 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S17 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S17 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S17 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S17 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S17) (assign (added_parameter_aut a3 integer S17) (variable_value v0)))
	)

	(:action add_parameter_a3_S17_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a3 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a3 ?s2) (has_constraint a3 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S17 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S17 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S17 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S17 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S17) (assign (added_parameter_aut a3 integer S17) (variable_value v15)))
	)

	(:action add_parameter_a3_S17_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a3 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a3 ?s2) (has_constraint a3 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S17 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S17 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S17 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S17 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S17) (assign (added_parameter_aut a3 integer S17) (variable_value v30)))
	)

	(:action add_parameter_a18_S15_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a18 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a18 ?s2) (has_constraint a18 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S15 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S15 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S15 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S15 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S15) (assign (added_parameter_aut a18 integer S15) (variable_value v30)))
	)

	(:action add_parameter_a18_S15_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a18 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a18 ?s2) (has_constraint a18 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S15 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S15 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S15 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S15 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S15) (assign (added_parameter_aut a18 integer S15) (variable_value v0)))
	)

	(:action add_parameter_a18_S15_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a18 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a18 ?s2) (has_constraint a18 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S15 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S15 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S15 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S15 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S15) (assign (added_parameter_aut a18 integer S15) (variable_value v15)))
	)

	(:action add_parameter_a15_S7_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a15 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a15 ?s2) (has_constraint a15 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S7 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S7 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S7 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S7 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S7) (assign (added_parameter_aut a15 integer S7) (variable_value v5)))
	)

	(:action add_parameter_a19_S0_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a19 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a19 ?s2) (has_constraint a19 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S0 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S0 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S0 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S0 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S0) (assign (added_parameter_aut a19 integer S0) (variable_value v5)))
	)

	(:action add_parameter_a15_S7_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a15 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a15 ?s2) (has_constraint a15 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S7 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S7 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S7 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S7 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S7) (assign (added_parameter_aut a15 integer S7) (variable_value v15)))
	)

	(:action add_parameter_a15_S7_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a15 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a15 ?s2) (has_constraint a15 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S7 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S7 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S7 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S7 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S7) (assign (added_parameter_aut a15 integer S7) (variable_value v30)))
	)

	(:action add_parameter_a15_S7_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a15 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a15 ?s2) (has_constraint a15 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S7 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S7 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S7 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S7 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S7) (assign (added_parameter_aut a15 integer S7) (variable_value v0)))
	)

	(:action add_parameter_a19_S0_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a19 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a19 ?s2) (has_constraint a19 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S0 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S0 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S0 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S0 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S0) (assign (added_parameter_aut a19 integer S0) (variable_value v30)))
	)

	(:action add_parameter_a19_S0_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a19 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a19 ?s2) (has_constraint a19 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S0 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S0 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S0 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S0 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S0) (assign (added_parameter_aut a19 integer S0) (variable_value v0)))
	)

	(:action add_parameter_a19_S0_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a19 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a19 ?s2) (has_constraint a19 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S0 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S0 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S0 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S0 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S0) (assign (added_parameter_aut a19 integer S0) (variable_value v15)))
	)

	(:action add_parameter_a9_S0_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a9 categorical S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a9 ?s2) (has_constraint a9 categorical S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S0 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S0 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S0 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S0 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S0) (assign (added_parameter_aut a9 categorical S0) (variable_value c1)))
	)

	(:action add_parameter_a9_S0_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a9 categorical S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a9 ?s2) (has_constraint a9 categorical S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S0 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S0 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S0 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S0 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S0) (assign (added_parameter_aut a9 categorical S0) (variable_value c2)))
	)

	(:action add_parameter_a9_S0_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a9 categorical S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a9 ?s2) (has_constraint a9 categorical S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S0 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S0 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S0 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S0 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S0) (assign (added_parameter_aut a9 categorical S0) (variable_value c3)))
	)

	(:action validate-payload_t1_a0_t2
		:parameters ()
		:precondition (and (cur_t_state t1) (trace t1 a0 t2) (not (after_sync)) (not (after_add)) (not (failure)) (not (complete_sync a0)) (not (after_add_check)) (not (exists (?c - constraint) (violated ?c) )) (not (recovery_finished)) (exists (?s1 - automaton_state ?s2 - automaton_state ) (and (cur_s_state ?s1) (not (failure_state ?s1)) (not (goal_state ?s1)) (automaton ?s1 a0 ?s2) (not (invalid ?s1 a0 ?s2)) ) ))
		:effect (and (increase (total_cost) 0) (after_sync) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a0 ?s2) (has_constraint a0 ?pn ?s1 ?s2) (or (not (has_parameter a0 ?pn t1 t2)) (< (trace_parameter a0 ?pn t1 t2) (majority_constraint a0 ?pn ?s1 ?s2)) (> (trace_parameter a0 ?pn t1 t2) (minority_constraint a0 ?pn ?s1 ?s2)) (< (trace_parameter a0 ?pn t1 t2) (interval_constraint_lower a0 ?pn ?s1 ?s2)) (> (trace_parameter a0 ?pn t1 t2) (interval_constraint_higher a0 ?pn ?s1 ?s2)) (< (trace_parameter a0 ?pn t1 t2) (equality_constraint a0 ?pn ?s1 ?s2)) (> (trace_parameter a0 ?pn t1 t2) (equality_constraint a0 ?pn ?s1 ?s2)) (= (trace_parameter a0 ?pn t1 t2) (inequality_constraint a0 ?pn ?s1 ?s2)) ) ) (invalid ?s1 a0 ?s2) ) ) )
	)

	(:action add_parameter_a10_S8_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a10 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a10 ?s2) (has_constraint a10 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S8 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S8 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S8 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S8 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S8) (assign (added_parameter_aut a10 integer S8) (variable_value v0)))
	)

	(:action add_parameter_a10_S8_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a10 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a10 ?s2) (has_constraint a10 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S8 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S8 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S8 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S8 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S8) (assign (added_parameter_aut a10 integer S8) (variable_value v30)))
	)

	(:action add_parameter_a9_S13_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a9 categorical S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a9 ?s2) (has_constraint a9 categorical S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S13 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S13 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S13 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S13 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S13) (assign (added_parameter_aut a9 categorical S13) (variable_value c3)))
	)

	(:action add_parameter_a10_S8_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a10 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a10 ?s2) (has_constraint a10 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S8 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S8 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S8 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S8 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S8) (assign (added_parameter_aut a10 integer S8) (variable_value v15)))
	)

	(:action add_parameter_a6_S2_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a6 categorical S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a6 ?s2) (has_constraint a6 categorical S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S2 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S2 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S2 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S2 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S2) (assign (added_parameter_aut a6 categorical S2) (variable_value c2)))
	)

	(:action add_parameter_a10_S8_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a10 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a10 ?s2) (has_constraint a10 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S8 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S8 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S8 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S8 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S8) (assign (added_parameter_aut a10 integer S8) (variable_value v5)))
	)

	(:action add_parameter_a1_S17_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a1 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a1 ?s2) (has_constraint a1 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S17 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S17 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S17 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S17 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S17) (assign (added_parameter_aut a1 integer S17) (variable_value v30)))
	)

	(:action add_parameter_a16_S15_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a16 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a16 ?s2) (has_constraint a16 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S15 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S15 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S15 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S15 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S15) (assign (added_parameter_aut a16 integer S15) (variable_value v30)))
	)

	(:action add_parameter_a1_S17_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a1 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a1 ?s2) (has_constraint a1 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S17 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S17 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S17 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S17 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S17) (assign (added_parameter_aut a1 integer S17) (variable_value v15)))
	)

	(:action add_parameter_a1_S17_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a1 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a1 ?s2) (has_constraint a1 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S17 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S17 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S17 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S17 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S17) (assign (added_parameter_aut a1 integer S17) (variable_value v0)))
	)

	(:action add_parameter_a6_S2_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a6 categorical S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a6 ?s2) (has_constraint a6 categorical S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S2 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S2 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S2 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S2 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S2) (assign (added_parameter_aut a6 categorical S2) (variable_value c1)))
	)

	(:action add_parameter_a2_S8_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a2 categorical S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a2 ?s2) (has_constraint a2 categorical S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S8 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S8 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S8 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S8 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S8) (assign (added_parameter_aut a2 categorical S8) (variable_value c3)))
	)

	(:action add_parameter_a1_S17_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a1 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a1 ?s2) (has_constraint a1 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S17 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S17 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S17 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S17 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S17) (assign (added_parameter_aut a1 integer S17) (variable_value v5)))
	)

	(:action add_parameter_a2_S8_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a2 categorical S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a2 ?s2) (has_constraint a2 categorical S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S8 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S8 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S8 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S8 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S8) (assign (added_parameter_aut a2 categorical S8) (variable_value c2)))
	)

	(:action add_parameter_a2_S8_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a2 categorical S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a2 ?s2) (has_constraint a2 categorical S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S8 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S8 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S8 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S8 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S8) (assign (added_parameter_aut a2 categorical S8) (variable_value c1)))
	)

	(:action add_parameter_a6_S2_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a6 categorical S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a6 ?s2) (has_constraint a6 categorical S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S2 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S2 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S2 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S2 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S2) (assign (added_parameter_aut a6 categorical S2) (variable_value c3)))
	)

	(:action add_parameter_a16_S15_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a16 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a16 ?s2) (has_constraint a16 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S15 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S15 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S15 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S15 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S15) (assign (added_parameter_aut a16 integer S15) (variable_value v5)))
	)

	(:action add_parameter_a16_S15_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a16 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a16 ?s2) (has_constraint a16 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S15 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S15 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S15 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S15 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S15) (assign (added_parameter_aut a16 integer S15) (variable_value v15)))
	)

	(:action add_parameter_a16_S15_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a16 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a16 ?s2) (has_constraint a16 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S15 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S15 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S15 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S15 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S15) (assign (added_parameter_aut a16 integer S15) (variable_value v0)))
	)

	(:action add_parameter_a6_S18_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a6 categorical S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a6 ?s2) (has_constraint a6 categorical S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S18 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S18 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S18 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S18 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S18) (assign (added_parameter_aut a6 categorical S18) (variable_value c3)))
	)

	(:action add_parameter_a6_S18_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a6 categorical S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a6 ?s2) (has_constraint a6 categorical S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S18 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S18 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S18 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S18 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S18) (assign (added_parameter_aut a6 categorical S18) (variable_value c1)))
	)

	(:action add_parameter_a19_S13_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a19 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a19 ?s2) (has_constraint a19 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S13 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S13 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S13 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S13 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S13) (assign (added_parameter_aut a19 integer S13) (variable_value v0)))
	)

	(:action add_parameter_a19_S13_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a19 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a19 ?s2) (has_constraint a19 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S13 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S13 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S13 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S13 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S13) (assign (added_parameter_aut a19 integer S13) (variable_value v15)))
	)

	(:action add_parameter_a19_S13_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a19 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a19 ?s2) (has_constraint a19 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S13 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S13 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S13 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S13 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S13) (assign (added_parameter_aut a19 integer S13) (variable_value v5)))
	)

	(:action add_parameter_a9_S13_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a9 categorical S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a9 ?s2) (has_constraint a9 categorical S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S13 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S13 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S13 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S13 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S13) (assign (added_parameter_aut a9 categorical S13) (variable_value c1)))
	)

	(:action add_parameter_a19_S13_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a19 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a19 ?s2) (has_constraint a19 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S13 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S13 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S13 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S13 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S13) (assign (added_parameter_aut a19 integer S13) (variable_value v30)))
	)

	(:action add_parameter_a9_S13_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a9 categorical S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a9 ?s2) (has_constraint a9 categorical S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S13 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S13 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S13 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S13 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S13) (assign (added_parameter_aut a9 categorical S13) (variable_value c2)))
	)

	(:action add_parameter_a12_S5_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a12 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a12 ?s2) (has_constraint a12 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S5 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S5 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S5 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S5 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S5) (assign (added_parameter_aut a12 integer S5) (variable_value v15)))
	)

	(:action add_parameter_a16_sDEC1_1_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a16 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a16 ?s2) (has_constraint a16 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer sDEC1_1 ?s2)) (< (variable_value v15) (minority_constraint a16 integer sDEC1_1 ?s2)) (= (variable_value v15) (equality_constraint a16 integer sDEC1_1 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer sDEC1_1 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer sDEC1_1) (assign (added_parameter_aut a16 integer sDEC1_1) (variable_value v15)))
	)

	(:action add_parameter_a16_sDEC1_1_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a16 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a16 ?s2) (has_constraint a16 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer sDEC1_1 ?s2)) (< (variable_value v5) (minority_constraint a16 integer sDEC1_1 ?s2)) (= (variable_value v5) (equality_constraint a16 integer sDEC1_1 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer sDEC1_1 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer sDEC1_1) (assign (added_parameter_aut a16 integer sDEC1_1) (variable_value v5)))
	)

	(:action add_parameter_a12_S5_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a12 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a12 ?s2) (has_constraint a12 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S5 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S5 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S5 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S5 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S5) (assign (added_parameter_aut a12 integer S5) (variable_value v30)))
	)

	(:action add_parameter_a11_S11_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a11 categorical S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a11 ?s2) (has_constraint a11 categorical S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S11 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S11 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S11 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S11 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S11) (assign (added_parameter_aut a11 categorical S11) (variable_value c1)))
	)

	(:action add_parameter_a12_S5_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a12 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a12 ?s2) (has_constraint a12 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S5 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S5 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S5 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S5 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S5) (assign (added_parameter_aut a12 integer S5) (variable_value v0)))
	)

	(:action add_parameter_a11_S11_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a11 categorical S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a11 ?s2) (has_constraint a11 categorical S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S11 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S11 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S11 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S11 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S11) (assign (added_parameter_aut a11 categorical S11) (variable_value c3)))
	)

	(:action add_parameter_a11_S11_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a11 categorical S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a11 ?s2) (has_constraint a11 categorical S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S11 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S11 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S11 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S11 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S11) (assign (added_parameter_aut a11 categorical S11) (variable_value c2)))
	)

	(:action add_parameter_a16_sDEC1_1_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a16 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a16 ?s2) (has_constraint a16 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer sDEC1_1 ?s2)) (< (variable_value v30) (minority_constraint a16 integer sDEC1_1 ?s2)) (= (variable_value v30) (equality_constraint a16 integer sDEC1_1 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer sDEC1_1 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer sDEC1_1) (assign (added_parameter_aut a16 integer sDEC1_1) (variable_value v30)))
	)

	(:action add_parameter_a12_S5_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a12 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a12 ?s2) (has_constraint a12 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S5 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S5 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S5 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S5 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S5) (assign (added_parameter_aut a12 integer S5) (variable_value v5)))
	)

	(:action add_parameter_a16_sDEC1_1_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a16 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a16 ?s2) (has_constraint a16 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer sDEC1_1 ?s2)) (< (variable_value v0) (minority_constraint a16 integer sDEC1_1 ?s2)) (= (variable_value v0) (equality_constraint a16 integer sDEC1_1 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer sDEC1_1 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer sDEC1_1) (assign (added_parameter_aut a16 integer sDEC1_1) (variable_value v0)))
	)

	(:action add_parameter_a3_S7_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a3 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a3 ?s2) (has_constraint a3 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S7 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S7 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S7 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S7 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S7) (assign (added_parameter_aut a3 integer S7) (variable_value v0)))
	)

	(:action add_parameter_a18_S1_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a18 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a18 ?s2) (has_constraint a18 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S1 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S1 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S1 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S1 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S1) (assign (added_parameter_aut a18 integer S1) (variable_value v0)))
	)

	(:action add_parameter_a3_S7_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a3 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a3 ?s2) (has_constraint a3 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S7 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S7 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S7 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S7 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S7) (assign (added_parameter_aut a3 integer S7) (variable_value v15)))
	)

	(:action add_parameter_a18_S1_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a18 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a18 ?s2) (has_constraint a18 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S1 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S1 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S1 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S1 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S1) (assign (added_parameter_aut a18 integer S1) (variable_value v15)))
	)

	(:action add_parameter_a3_S7_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a3 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a3 ?s2) (has_constraint a3 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S7 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S7 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S7 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S7 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S7) (assign (added_parameter_aut a3 integer S7) (variable_value v30)))
	)

	(:action add_parameter_a18_S1_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a18 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a18 ?s2) (has_constraint a18 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S1 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S1 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S1 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S1 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S1) (assign (added_parameter_aut a18 integer S1) (variable_value v5)))
	)

	(:action add_parameter_a3_S7_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a3 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a3 ?s2) (has_constraint a3 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S7 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S7 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S7 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S7 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S7) (assign (added_parameter_aut a3 integer S7) (variable_value v5)))
	)

	(:action add_parameter_a6_S18_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a6 categorical S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a6 ?s2) (has_constraint a6 categorical S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S18 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S18 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S18 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S18 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S18) (assign (added_parameter_aut a6 categorical S18) (variable_value c2)))
	)

	(:action add_parameter_a18_S1_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a18 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a18 ?s2) (has_constraint a18 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S1 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S1 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S1 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S1 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S1) (assign (added_parameter_aut a18 integer S1) (variable_value v30)))
	)

	(:action add_parameter_a19_sDEC1_2_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a19 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a19 ?s2) (has_constraint a19 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer sDEC1_2 ?s2)) (< (variable_value v15) (minority_constraint a19 integer sDEC1_2 ?s2)) (= (variable_value v15) (equality_constraint a19 integer sDEC1_2 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer sDEC1_2 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer sDEC1_2) (assign (added_parameter_aut a19 integer sDEC1_2) (variable_value v15)))
	)

	(:action add_parameter_a15_S6_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a15 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a15 ?s2) (has_constraint a15 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S6 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S6 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S6 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S6 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S6) (assign (added_parameter_aut a15 integer S6) (variable_value v15)))
	)

	(:action add_parameter_a15_S6_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a15 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a15 ?s2) (has_constraint a15 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S6 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S6 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S6 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S6 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S6) (assign (added_parameter_aut a15 integer S6) (variable_value v30)))
	)

	(:action add_parameter_a19_sDEC1_2_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a19 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a19 ?s2) (has_constraint a19 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer sDEC1_2 ?s2)) (< (variable_value v5) (minority_constraint a19 integer sDEC1_2 ?s2)) (= (variable_value v5) (equality_constraint a19 integer sDEC1_2 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer sDEC1_2 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer sDEC1_2) (assign (added_parameter_aut a19 integer sDEC1_2) (variable_value v5)))
	)

	(:action add_parameter_a15_S6_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a15 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a15 ?s2) (has_constraint a15 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S6 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S6 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S6 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S6 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S6) (assign (added_parameter_aut a15 integer S6) (variable_value v0)))
	)

	(:action sync-actions_t2_t3_a1
		:parameters ()
		:precondition (and (not (after_add)) (not (failure)) (not (after_add_check)) (not (complete_sync a1)) (after_sync) (cur_t_state t2) (trace t2 a1 t3) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (automaton ?s1 a1 ?s2) ) ) )
		:effect (and (increase (total_cost) 0) (not (cur_t_state t2)) (cur_t_state t3) (when (final_t_state t3) (recovery_finished)) (not (after_sync)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (not (invalid ?s1 a1 ?s2)) (automaton ?s1 a1 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) )) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a1 ?s2)) (automaton ?s1 a1 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (invalid ?s1 a1 ?s2) (automaton ?s1 a1 ?s2) ) (not (invalid ?s1 a1 ?s2)) ) ) )
	)

	(:action add_parameter_a9_sDEC1_2_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a9 categorical sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a9 ?s2) (has_constraint a9 categorical sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical sDEC1_2 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical sDEC1_2 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical sDEC1_2 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical sDEC1_2 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical sDEC1_2) (assign (added_parameter_aut a9 categorical sDEC1_2) (variable_value c2)))
	)

	(:action add_parameter_a19_sDEC1_2_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a19 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a19 ?s2) (has_constraint a19 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer sDEC1_2 ?s2)) (< (variable_value v30) (minority_constraint a19 integer sDEC1_2 ?s2)) (= (variable_value v30) (equality_constraint a19 integer sDEC1_2 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer sDEC1_2 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer sDEC1_2) (assign (added_parameter_aut a19 integer sDEC1_2) (variable_value v30)))
	)

	(:action add_parameter_a15_S6_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a15 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a15 ?s2) (has_constraint a15 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S6 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S6 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S6 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S6 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S6) (assign (added_parameter_aut a15 integer S6) (variable_value v5)))
	)

	(:action add_parameter_a19_sDEC1_2_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a19 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a19 ?s2) (has_constraint a19 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer sDEC1_2 ?s2)) (< (variable_value v0) (minority_constraint a19 integer sDEC1_2 ?s2)) (= (variable_value v0) (equality_constraint a19 integer sDEC1_2 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer sDEC1_2 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer sDEC1_2) (assign (added_parameter_aut a19 integer sDEC1_2) (variable_value v0)))
	)

	(:action add_parameter_a9_sDEC1_2_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a9 categorical sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a9 ?s2) (has_constraint a9 categorical sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical sDEC1_2 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical sDEC1_2 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical sDEC1_2 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical sDEC1_2 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical sDEC1_2) (assign (added_parameter_aut a9 categorical sDEC1_2) (variable_value c1)))
	)

	(:action add_parameter_a9_sDEC1_2_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a9 categorical sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a9 ?s2) (has_constraint a9 categorical sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical sDEC1_2 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical sDEC1_2 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical sDEC1_2 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical sDEC1_2 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical sDEC1_2) (assign (added_parameter_aut a9 categorical sDEC1_2) (variable_value c3)))
	)

	(:action add_parameter_a10_S13_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a10 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a10 ?s2) (has_constraint a10 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S13 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S13 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S13 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S13 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S13) (assign (added_parameter_aut a10 integer S13) (variable_value v15)))
	)

	(:action add_parameter_a10_S13_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a10 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a10 ?s2) (has_constraint a10 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S13 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S13 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S13 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S13 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S13) (assign (added_parameter_aut a10 integer S13) (variable_value v5)))
	)

	(:action add_parameter_a11_sDEC1_1_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a11 categorical sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a11 ?s2) (has_constraint a11 categorical sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical sDEC1_1 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical sDEC1_1 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical sDEC1_1 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical sDEC1_1 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical sDEC1_1) (assign (added_parameter_aut a11 categorical sDEC1_1) (variable_value c3)))
	)

	(:action add_parameter_a18_S2_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a18 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a18 ?s2) (has_constraint a18 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S2 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S2 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S2 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S2 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S2) (assign (added_parameter_aut a18 integer S2) (variable_value v30)))
	)

	(:action add_parameter_a18_S2_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a18 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a18 ?s2) (has_constraint a18 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S2 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S2 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S2 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S2 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S2) (assign (added_parameter_aut a18 integer S2) (variable_value v0)))
	)

	(:action add_parameter_a18_S2_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a18 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a18 ?s2) (has_constraint a18 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S2 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S2 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S2 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S2 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S2) (assign (added_parameter_aut a18 integer S2) (variable_value v15)))
	)

	(:action add_parameter_a18_S2_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a18 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a18 ?s2) (has_constraint a18 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S2 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S2 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S2 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S2 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S2) (assign (added_parameter_aut a18 integer S2) (variable_value v5)))
	)

	(:action add_parameter_a2_S13_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a2 categorical S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a2 ?s2) (has_constraint a2 categorical S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S13 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S13 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S13 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S13 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S13) (assign (added_parameter_aut a2 categorical S13) (variable_value c2)))
	)

	(:action add_parameter_a6_S8_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a6 categorical S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a6 ?s2) (has_constraint a6 categorical S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S8 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S8 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S8 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S8 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S8) (assign (added_parameter_aut a6 categorical S8) (variable_value c1)))
	)

	(:action add_parameter_a6_S8_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a6 categorical S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a6 ?s2) (has_constraint a6 categorical S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S8 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S8 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S8 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S8 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S8) (assign (added_parameter_aut a6 categorical S8) (variable_value c2)))
	)

	(:action add_parameter_a2_S13_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a2 categorical S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a2 ?s2) (has_constraint a2 categorical S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S13 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S13 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S13 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S13 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S13) (assign (added_parameter_aut a2 categorical S13) (variable_value c3)))
	)

	(:action add_parameter_a6_S8_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a6 categorical S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a6 ?s2) (has_constraint a6 categorical S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S8 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S8 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S8 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S8 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S8) (assign (added_parameter_aut a6 categorical S8) (variable_value c3)))
	)

	(:action add_parameter_a1_S15_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a1 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a1 ?s2) (has_constraint a1 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S15 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S15 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S15 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S15 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S15) (assign (added_parameter_aut a1 integer S15) (variable_value v30)))
	)

	(:action add_parameter_a10_S13_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a10 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a10 ?s2) (has_constraint a10 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S13 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S13 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S13 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S13 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S13) (assign (added_parameter_aut a10 integer S13) (variable_value v0)))
	)

	(:action add_parameter_a10_S13_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a10 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a10 ?s2) (has_constraint a10 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S13 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S13 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S13 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S13 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S13) (assign (added_parameter_aut a10 integer S13) (variable_value v30)))
	)

	(:action add_parameter_a1_S15_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a1 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a1 ?s2) (has_constraint a1 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S15 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S15 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S15 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S15 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S15) (assign (added_parameter_aut a1 integer S15) (variable_value v15)))
	)

	(:action add_parameter_a1_S15_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a1 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a1 ?s2) (has_constraint a1 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S15 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S15 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S15 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S15 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S15) (assign (added_parameter_aut a1 integer S15) (variable_value v0)))
	)

	(:action add_parameter_a2_S13_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a2 categorical S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a2 ?s2) (has_constraint a2 categorical S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S13 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S13 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S13 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S13 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S13) (assign (added_parameter_aut a2 categorical S13) (variable_value c1)))
	)

	(:action add_parameter_a1_S15_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a1 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a1 ?s2) (has_constraint a1 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S15 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S15 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S15 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S15 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S15) (assign (added_parameter_aut a1 integer S15) (variable_value v5)))
	)

	(:action add_parameter_a11_sDEC1_1_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a11 categorical sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a11 ?s2) (has_constraint a11 categorical sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical sDEC1_1 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical sDEC1_1 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical sDEC1_1 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical sDEC1_1 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical sDEC1_1) (assign (added_parameter_aut a11 categorical sDEC1_1) (variable_value c1)))
	)

	(:action add_parameter_a11_sDEC1_1_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a11 categorical sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a11 ?s2) (has_constraint a11 categorical sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical sDEC1_1 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical sDEC1_1 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical sDEC1_1 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical sDEC1_1 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical sDEC1_1) (assign (added_parameter_aut a11 categorical sDEC1_1) (variable_value c2)))
	)

	(:action add_parameter_a2_sDEC1_2_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a2 categorical sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a2 ?s2) (has_constraint a2 categorical sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical sDEC1_2 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical sDEC1_2 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical sDEC1_2 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical sDEC1_2 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical sDEC1_2) (assign (added_parameter_aut a2 categorical sDEC1_2) (variable_value c2)))
	)

	(:action add_parameter_a16_S5_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a16 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a16 ?s2) (has_constraint a16 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S5 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S5 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S5 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S5 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S5) (assign (added_parameter_aut a16 integer S5) (variable_value v5)))
	)

	(:action add_parameter_a11_S14_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a11 categorical S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a11 ?s2) (has_constraint a11 categorical S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S14 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S14 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S14 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S14 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S14) (assign (added_parameter_aut a11 categorical S14) (variable_value c1)))
	)

	(:action add_parameter_a12_S10_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a12 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a12 ?s2) (has_constraint a12 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S10 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S10 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S10 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S10 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S10) (assign (added_parameter_aut a12 integer S10) (variable_value v5)))
	)

	(:action add_parameter_a16_S5_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a16 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a16 ?s2) (has_constraint a16 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S5 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S5 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S5 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S5 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S5) (assign (added_parameter_aut a16 integer S5) (variable_value v15)))
	)

	(:action add_parameter_a12_S10_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a12 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a12 ?s2) (has_constraint a12 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S10 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S10 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S10 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S10 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S10) (assign (added_parameter_aut a12 integer S10) (variable_value v15)))
	)

	(:action add_parameter_a16_S5_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a16 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a16 ?s2) (has_constraint a16 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S5 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S5 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S5 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S5 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S5) (assign (added_parameter_aut a16 integer S5) (variable_value v0)))
	)

	(:action add_parameter_a11_S14_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a11 categorical S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a11 ?s2) (has_constraint a11 categorical S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S14 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S14 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S14 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S14 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S14) (assign (added_parameter_aut a11 categorical S14) (variable_value c2)))
	)

	(:action add_parameter_a16_S5_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a16 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a16 ?s2) (has_constraint a16 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S5 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S5 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S5 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S5 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S5) (assign (added_parameter_aut a16 integer S5) (variable_value v30)))
	)

	(:action add_parameter_a10_sDEC1_2_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a10 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a10 ?s2) (has_constraint a10 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer sDEC1_2 ?s2)) (< (variable_value v30) (minority_constraint a10 integer sDEC1_2 ?s2)) (= (variable_value v30) (equality_constraint a10 integer sDEC1_2 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer sDEC1_2 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer sDEC1_2) (assign (added_parameter_aut a10 integer sDEC1_2) (variable_value v30)))
	)

	(:action add_parameter_a2_sDEC1_2_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a2 categorical sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a2 ?s2) (has_constraint a2 categorical sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical sDEC1_2 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical sDEC1_2 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical sDEC1_2 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical sDEC1_2 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical sDEC1_2) (assign (added_parameter_aut a2 categorical sDEC1_2) (variable_value c3)))
	)

	(:action add_parameter_a1_sDEC1_1_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a1 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a1 ?s2) (has_constraint a1 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer sDEC1_1 ?s2)) (< (variable_value v0) (minority_constraint a1 integer sDEC1_1 ?s2)) (= (variable_value v0) (equality_constraint a1 integer sDEC1_1 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer sDEC1_1 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer sDEC1_1) (assign (added_parameter_aut a1 integer sDEC1_1) (variable_value v0)))
	)

	(:action add_parameter_a10_sDEC1_2_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a10 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a10 ?s2) (has_constraint a10 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer sDEC1_2 ?s2)) (< (variable_value v15) (minority_constraint a10 integer sDEC1_2 ?s2)) (= (variable_value v15) (equality_constraint a10 integer sDEC1_2 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer sDEC1_2 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer sDEC1_2) (assign (added_parameter_aut a10 integer sDEC1_2) (variable_value v15)))
	)

	(:action add_parameter_a1_sDEC1_1_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a1 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a1 ?s2) (has_constraint a1 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer sDEC1_1 ?s2)) (< (variable_value v30) (minority_constraint a1 integer sDEC1_1 ?s2)) (= (variable_value v30) (equality_constraint a1 integer sDEC1_1 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer sDEC1_1 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer sDEC1_1) (assign (added_parameter_aut a1 integer sDEC1_1) (variable_value v30)))
	)

	(:action add_parameter_a10_sDEC1_2_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a10 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a10 ?s2) (has_constraint a10 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer sDEC1_2 ?s2)) (< (variable_value v0) (minority_constraint a10 integer sDEC1_2 ?s2)) (= (variable_value v0) (equality_constraint a10 integer sDEC1_2 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer sDEC1_2 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer sDEC1_2) (assign (added_parameter_aut a10 integer sDEC1_2) (variable_value v0)))
	)

	(:action add_parameter_a2_sDEC1_2_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a2 categorical sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a2 ?s2) (has_constraint a2 categorical sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical sDEC1_2 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical sDEC1_2 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical sDEC1_2 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical sDEC1_2 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical sDEC1_2) (assign (added_parameter_aut a2 categorical sDEC1_2) (variable_value c1)))
	)

	(:action add_parameter_a1_sDEC1_1_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a1 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a1 ?s2) (has_constraint a1 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer sDEC1_1 ?s2)) (< (variable_value v15) (minority_constraint a1 integer sDEC1_1 ?s2)) (= (variable_value v15) (equality_constraint a1 integer sDEC1_1 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer sDEC1_1 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer sDEC1_1) (assign (added_parameter_aut a1 integer sDEC1_1) (variable_value v15)))
	)

	(:action add_parameter_a1_sDEC1_1_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a1 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a1 ?s2) (has_constraint a1 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer sDEC1_1 ?s2)) (< (variable_value v5) (minority_constraint a1 integer sDEC1_1 ?s2)) (= (variable_value v5) (equality_constraint a1 integer sDEC1_1 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer sDEC1_1 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer sDEC1_1) (assign (added_parameter_aut a1 integer sDEC1_1) (variable_value v5)))
	)

	(:action add_parameter_a11_S14_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a11 categorical S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a11 ?s2) (has_constraint a11 categorical S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S14 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S14 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S14 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S14 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S14) (assign (added_parameter_aut a11 categorical S14) (variable_value c3)))
	)

	(:action add_parameter_a12_S10_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a12 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a12 ?s2) (has_constraint a12 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S10 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S10 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S10 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S10 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S10) (assign (added_parameter_aut a12 integer S10) (variable_value v30)))
	)

	(:action add_parameter_a3_S1_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a3 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a3 ?s2) (has_constraint a3 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S1 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S1 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S1 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S1 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S1) (assign (added_parameter_aut a3 integer S1) (variable_value v30)))
	)

	(:action add_parameter_a18_S18_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a18 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a18 ?s2) (has_constraint a18 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S18 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S18 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S18 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S18 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S18) (assign (added_parameter_aut a18 integer S18) (variable_value v30)))
	)

	(:action add_parameter_a12_S10_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a12 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a12 ?s2) (has_constraint a12 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S10 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S10 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S10 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S10 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S10) (assign (added_parameter_aut a12 integer S10) (variable_value v0)))
	)

	(:action add_parameter_a18_S18_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a18 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a18 ?s2) (has_constraint a18 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S18 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S18 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S18 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S18 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S18) (assign (added_parameter_aut a18 integer S18) (variable_value v0)))
	)

	(:action add_parameter_a18_S18_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a18 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a18 ?s2) (has_constraint a18 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S18 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S18 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S18 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S18 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S18) (assign (added_parameter_aut a18 integer S18) (variable_value v15)))
	)

	(:action add_parameter_a18_S18_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a18 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a18 ?s2) (has_constraint a18 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S18 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S18 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S18 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S18 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S18) (assign (added_parameter_aut a18 integer S18) (variable_value v5)))
	)

	(:action add_parameter_a3_S1_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a3 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a3 ?s2) (has_constraint a3 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S1 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S1 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S1 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S1 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S1) (assign (added_parameter_aut a3 integer S1) (variable_value v5)))
	)

	(:action add_parameter_a3_S1_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a3 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a3 ?s2) (has_constraint a3 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S1 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S1 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S1 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S1 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S1) (assign (added_parameter_aut a3 integer S1) (variable_value v0)))
	)

	(:action add_parameter_a3_S1_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a3 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a3 ?s2) (has_constraint a3 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S1 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S1 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S1 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S1 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S1) (assign (added_parameter_aut a3 integer S1) (variable_value v15)))
	)

	(:action add_parameter_a15_S11_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a15 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a15 ?s2) (has_constraint a15 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S11 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S11 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S11 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S11 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S11) (assign (added_parameter_aut a15 integer S11) (variable_value v5)))
	)

	(:action add_parameter_a15_S11_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a15 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a15 ?s2) (has_constraint a15 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S11 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S11 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S11 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S11 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S11) (assign (added_parameter_aut a15 integer S11) (variable_value v15)))
	)

	(:action add_parameter_a19_S6_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a19 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a19 ?s2) (has_constraint a19 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S6 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S6 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S6 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S6 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S6) (assign (added_parameter_aut a19 integer S6) (variable_value v30)))
	)

	(:action add_parameter_a19_S6_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a19 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a19 ?s2) (has_constraint a19 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S6 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S6 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S6 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S6 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S6) (assign (added_parameter_aut a19 integer S6) (variable_value v0)))
	)

	(:action add_parameter_a19_S6_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a19 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a19 ?s2) (has_constraint a19 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S6 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S6 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S6 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S6 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S6) (assign (added_parameter_aut a19 integer S6) (variable_value v15)))
	)

	(:action add_parameter_a19_S6_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a19 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a19 ?s2) (has_constraint a19 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S6 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S6 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S6 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S6 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S6) (assign (added_parameter_aut a19 integer S6) (variable_value v5)))
	)

	(:action add_parameter_a9_S6_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a9 categorical S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a9 ?s2) (has_constraint a9 categorical S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S6 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S6 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S6 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S6 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S6) (assign (added_parameter_aut a9 categorical S6) (variable_value c1)))
	)

	(:action add_parameter_a10_sDEC1_2_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a10 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a10 ?s2) (has_constraint a10 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer sDEC1_2 ?s2)) (< (variable_value v5) (minority_constraint a10 integer sDEC1_2 ?s2)) (= (variable_value v5) (equality_constraint a10 integer sDEC1_2 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer sDEC1_2 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer sDEC1_2) (assign (added_parameter_aut a10 integer sDEC1_2) (variable_value v5)))
	)

	(:action add_parameter_a9_S6_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a9 categorical S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a9 ?s2) (has_constraint a9 categorical S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S6 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S6 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S6 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S6 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S6) (assign (added_parameter_aut a9 categorical S6) (variable_value c2)))
	)

	(:action add_parameter_a15_S11_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a15 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a15 ?s2) (has_constraint a15 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S11 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S11 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S11 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S11 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S11) (assign (added_parameter_aut a15 integer S11) (variable_value v30)))
	)

	(:action add_parameter_a9_S6_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a9 categorical S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a9 ?s2) (has_constraint a9 categorical S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S6 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S6 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S6 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S6 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S6) (assign (added_parameter_aut a9 categorical S6) (variable_value c3)))
	)

	(:action add_parameter_a15_S11_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a15 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a15 ?s2) (has_constraint a15 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S11 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S11 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S11 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S11 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S11) (assign (added_parameter_aut a15 integer S11) (variable_value v0)))
	)

	(:action add_parameter_a18_sDEC1_1_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a18 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a18 ?s2) (has_constraint a18 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer sDEC1_1 ?s2)) (< (variable_value v5) (minority_constraint a18 integer sDEC1_1 ?s2)) (= (variable_value v5) (equality_constraint a18 integer sDEC1_1 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer sDEC1_1 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer sDEC1_1) (assign (added_parameter_aut a18 integer sDEC1_1) (variable_value v5)))
	)

	(:action add_parameter_a9_S16_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a9 categorical S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a9 ?s2) (has_constraint a9 categorical S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S16 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S16 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S16 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S16 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S16) (assign (added_parameter_aut a9 categorical S16) (variable_value c1)))
	)

	(:action add_parameter_a10_S10_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a10 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a10 ?s2) (has_constraint a10 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S10 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S10 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S10 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S10 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S10) (assign (added_parameter_aut a10 integer S10) (variable_value v5)))
	)

	(:action add_parameter_a9_S16_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a9 categorical S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a9 ?s2) (has_constraint a9 categorical S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S16 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S16 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S16 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S16 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S16) (assign (added_parameter_aut a9 categorical S16) (variable_value c2)))
	)

	(:action add_parameter_a10_S10_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a10 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a10 ?s2) (has_constraint a10 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S10 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S10 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S10 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S10 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S10) (assign (added_parameter_aut a10 integer S10) (variable_value v0)))
	)

	(:action add_parameter_a10_S10_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a10 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a10 ?s2) (has_constraint a10 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S10 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S10 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S10 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S10 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S10) (assign (added_parameter_aut a10 integer S10) (variable_value v30)))
	)

	(:action add_parameter_a9_S16_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a9 categorical S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a9 ?s2) (has_constraint a9 categorical S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S16 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S16 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S16 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S16 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S16) (assign (added_parameter_aut a9 categorical S16) (variable_value c3)))
	)

	(:action add_parameter_a10_S10_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a10 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a10 ?s2) (has_constraint a10 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S10 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S10 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S10 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S10 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S10) (assign (added_parameter_aut a10 integer S10) (variable_value v15)))
	)

	(:action add_parameter_a18_sDEC1_1_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a18 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a18 ?s2) (has_constraint a18 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer sDEC1_1 ?s2)) (< (variable_value v30) (minority_constraint a18 integer sDEC1_1 ?s2)) (= (variable_value v30) (equality_constraint a18 integer sDEC1_1 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer sDEC1_1 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer sDEC1_1) (assign (added_parameter_aut a18 integer sDEC1_1) (variable_value v30)))
	)

	(:action add_parameter_a18_sDEC1_1_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a18 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a18 ?s2) (has_constraint a18 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer sDEC1_1 ?s2)) (< (variable_value v0) (minority_constraint a18 integer sDEC1_1 ?s2)) (= (variable_value v0) (equality_constraint a18 integer sDEC1_1 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer sDEC1_1 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer sDEC1_1) (assign (added_parameter_aut a18 integer sDEC1_1) (variable_value v0)))
	)

	(:action add_parameter_a18_sDEC1_1_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a18 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a18 ?s2) (has_constraint a18 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer sDEC1_1 ?s2)) (< (variable_value v15) (minority_constraint a18 integer sDEC1_1 ?s2)) (= (variable_value v15) (equality_constraint a18 integer sDEC1_1 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer sDEC1_1 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer sDEC1_1) (assign (added_parameter_aut a18 integer sDEC1_1) (variable_value v15)))
	)

	(:action add_parameter_a1_S1_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a1 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a1 ?s2) (has_constraint a1 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S1 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S1 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S1 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S1 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S1) (assign (added_parameter_aut a1 integer S1) (variable_value v5)))
	)

	(:action add_parameter_a16_S18_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a16 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a16 ?s2) (has_constraint a16 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S18 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S18 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S18 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S18 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S18) (assign (added_parameter_aut a16 integer S18) (variable_value v5)))
	)

	(:action add_parameter_a2_S10_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a2 categorical S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a2 ?s2) (has_constraint a2 categorical S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S10 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S10 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S10 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S10 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S10) (assign (added_parameter_aut a2 categorical S10) (variable_value c2)))
	)

	(:action add_parameter_a6_S5_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a6 categorical S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a6 ?s2) (has_constraint a6 categorical S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S5 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S5 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S5 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S5 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S5) (assign (added_parameter_aut a6 categorical S5) (variable_value c2)))
	)

	(:action add_parameter_a16_S18_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a16 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a16 ?s2) (has_constraint a16 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S18 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S18 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S18 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S18 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S18) (assign (added_parameter_aut a16 integer S18) (variable_value v15)))
	)

	(:action add_parameter_a2_S10_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a2 categorical S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a2 ?s2) (has_constraint a2 categorical S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S10 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S10 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S10 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S10 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S10) (assign (added_parameter_aut a2 categorical S10) (variable_value c1)))
	)

	(:action add_parameter_a16_S18_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a16 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a16 ?s2) (has_constraint a16 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S18 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S18 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S18 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S18 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S18) (assign (added_parameter_aut a16 integer S18) (variable_value v0)))
	)

	(:action add_parameter_a16_S18_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a16 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a16 ?s2) (has_constraint a16 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S18 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S18 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S18 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S18 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S18) (assign (added_parameter_aut a16 integer S18) (variable_value v30)))
	)

	(:action add_parameter_a6_S5_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a6 categorical S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a6 ?s2) (has_constraint a6 categorical S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S5 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S5 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S5 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S5 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S5) (assign (added_parameter_aut a6 categorical S5) (variable_value c1)))
	)

	(:action add_parameter_a6_S5_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a6 categorical S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a6 ?s2) (has_constraint a6 categorical S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S5 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S5 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S5 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S5 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S5) (assign (added_parameter_aut a6 categorical S5) (variable_value c3)))
	)

	(:action add_parameter_a1_S1_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a1 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a1 ?s2) (has_constraint a1 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S1 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S1 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S1 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S1 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S1) (assign (added_parameter_aut a1 integer S1) (variable_value v30)))
	)

	(:action add_parameter_a1_S1_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a1 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a1 ?s2) (has_constraint a1 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S1 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S1 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S1 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S1 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S1) (assign (added_parameter_aut a1 integer S1) (variable_value v15)))
	)

	(:action add_parameter_a1_S1_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a1 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a1 ?s2) (has_constraint a1 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S1 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S1 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S1 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S1 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S1) (assign (added_parameter_aut a1 integer S1) (variable_value v0)))
	)

	(:action add_parameter_a2_S10_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a2 categorical S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a2 ?s2) (has_constraint a2 categorical S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S10 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S10 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S10 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S10 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S10) (assign (added_parameter_aut a2 categorical S10) (variable_value c3)))
	)

	(:action add_parameter_a19_S16_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a19 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a19 ?s2) (has_constraint a19 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S16 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S16 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S16 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S16 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S16) (assign (added_parameter_aut a19 integer S16) (variable_value v30)))
	)

	(:action add_parameter_a19_S16_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a19 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a19 ?s2) (has_constraint a19 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S16 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S16 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S16 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S16 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S16) (assign (added_parameter_aut a19 integer S16) (variable_value v0)))
	)

	(:action add_parameter_a19_S16_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a19 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a19 ?s2) (has_constraint a19 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S16 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S16 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S16 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S16 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S16) (assign (added_parameter_aut a19 integer S16) (variable_value v15)))
	)

	(:action add_parameter_a19_S16_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a19 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a19 ?s2) (has_constraint a19 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S16 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S16 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S16 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S16 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S16) (assign (added_parameter_aut a19 integer S16) (variable_value v5)))
	)

	(:action add_parameter_a11_S15_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a11 categorical S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a11 ?s2) (has_constraint a11 categorical S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S15 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S15 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S15 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S15 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S15) (assign (added_parameter_aut a11 categorical S15) (variable_value c2)))
	)

	(:action add_parameter_a12_S9_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a12 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a12 ?s2) (has_constraint a12 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S9 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S9 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S9 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S9 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S9) (assign (added_parameter_aut a12 integer S9) (variable_value v5)))
	)

	(:action add_parameter_a12_S9_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a12 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a12 ?s2) (has_constraint a12 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S9 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S9 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S9 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S9 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S9) (assign (added_parameter_aut a12 integer S9) (variable_value v15)))
	)

	(:action add_parameter_a12_S9_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a12 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a12 ?s2) (has_constraint a12 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S9 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S9 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S9 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S9 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S9) (assign (added_parameter_aut a12 integer S9) (variable_value v30)))
	)

	(:action add_parameter_a11_S15_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a11 categorical S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a11 ?s2) (has_constraint a11 categorical S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S15 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S15 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S15 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S15 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S15) (assign (added_parameter_aut a11 categorical S15) (variable_value c1)))
	)

	(:action add_parameter_a12_S9_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a12 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a12 ?s2) (has_constraint a12 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S9 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S9 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S9 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S9 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S9) (assign (added_parameter_aut a12 integer S9) (variable_value v0)))
	)

	(:action add_parameter_a16_S4_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a16 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a16 ?s2) (has_constraint a16 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S4 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S4 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S4 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S4 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S4) (assign (added_parameter_aut a16 integer S4) (variable_value v30)))
	)

	(:action add_parameter_a16_S4_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a16 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a16 ?s2) (has_constraint a16 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S4 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S4 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S4 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S4 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S4) (assign (added_parameter_aut a16 integer S4) (variable_value v0)))
	)

	(:action add_parameter_a16_S4_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a16 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a16 ?s2) (has_constraint a16 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S4 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S4 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S4 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S4 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S4) (assign (added_parameter_aut a16 integer S4) (variable_value v15)))
	)

	(:action add_parameter_a16_S4_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a16 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a16 ?s2) (has_constraint a16 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S4 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S4 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S4 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S4 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S4) (assign (added_parameter_aut a16 integer S4) (variable_value v5)))
	)

	(:action add_parameter_a3_S11_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a3 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a3 ?s2) (has_constraint a3 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S11 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S11 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S11 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S11 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S11) (assign (added_parameter_aut a3 integer S11) (variable_value v5)))
	)

	(:action validate-payload_t2_a1_t3
		:parameters ()
		:precondition (and (cur_t_state t2) (trace t2 a1 t3) (not (after_sync)) (not (after_add)) (not (failure)) (not (complete_sync a1)) (not (after_add_check)) (not (exists (?c - constraint) (violated ?c) )) (not (recovery_finished)) (exists (?s1 - automaton_state ?s2 - automaton_state ) (and (cur_s_state ?s1) (not (failure_state ?s1)) (not (goal_state ?s1)) (automaton ?s1 a1 ?s2) (not (invalid ?s1 a1 ?s2)) ) ))
		:effect (and (increase (total_cost) 0) (after_sync) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a1 ?s2) (has_constraint a1 ?pn ?s1 ?s2) (or (not (has_parameter a1 ?pn t2 t3)) (< (trace_parameter a1 ?pn t2 t3) (majority_constraint a1 ?pn ?s1 ?s2)) (> (trace_parameter a1 ?pn t2 t3) (minority_constraint a1 ?pn ?s1 ?s2)) (< (trace_parameter a1 ?pn t2 t3) (interval_constraint_lower a1 ?pn ?s1 ?s2)) (> (trace_parameter a1 ?pn t2 t3) (interval_constraint_higher a1 ?pn ?s1 ?s2)) (< (trace_parameter a1 ?pn t2 t3) (equality_constraint a1 ?pn ?s1 ?s2)) (> (trace_parameter a1 ?pn t2 t3) (equality_constraint a1 ?pn ?s1 ?s2)) (= (trace_parameter a1 ?pn t2 t3) (inequality_constraint a1 ?pn ?s1 ?s2)) ) ) (invalid ?s1 a1 ?s2) ) ) )
	)

	(:action add_parameter_a11_S15_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a11 categorical S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a11 ?s2) (has_constraint a11 categorical S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S15 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S15 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S15 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S15 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S15) (assign (added_parameter_aut a11 categorical S15) (variable_value c3)))
	)

	(:action add_parameter_a18_S14_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a18 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a18 ?s2) (has_constraint a18 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S14 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S14 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S14 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S14 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S14) (assign (added_parameter_aut a18 integer S14) (variable_value v30)))
	)

	(:action add_parameter_a3_S11_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a3 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a3 ?s2) (has_constraint a3 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S11 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S11 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S11 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S11 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S11) (assign (added_parameter_aut a3 integer S11) (variable_value v0)))
	)

	(:action add_parameter_a18_S14_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a18 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a18 ?s2) (has_constraint a18 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S14 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S14 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S14 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S14 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S14) (assign (added_parameter_aut a18 integer S14) (variable_value v0)))
	)

	(:action add_parameter_a3_S11_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a3 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a3 ?s2) (has_constraint a3 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S11 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S11 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S11 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S11 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S11) (assign (added_parameter_aut a3 integer S11) (variable_value v15)))
	)

	(:action add_parameter_a18_S14_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a18 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a18 ?s2) (has_constraint a18 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S14 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S14 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S14 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S14 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S14) (assign (added_parameter_aut a18 integer S14) (variable_value v15)))
	)

	(:action add_parameter_a3_S11_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a3 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a3 ?s2) (has_constraint a3 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S11 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S11 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S11 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S11 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S11) (assign (added_parameter_aut a3 integer S11) (variable_value v30)))
	)

	(:action add_parameter_a18_S14_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a18 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a18 ?s2) (has_constraint a18 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S14 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S14 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S14 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S14 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S14) (assign (added_parameter_aut a18 integer S14) (variable_value v5)))
	)

	(:action add_parameter_a15_S17_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a15 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a15 ?s2) (has_constraint a15 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S17 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S17 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S17 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S17 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S17) (assign (added_parameter_aut a15 integer S17) (variable_value v5)))
	)

	(:action add_parameter_a15_S17_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a15 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a15 ?s2) (has_constraint a15 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S17 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S17 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S17 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S17 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S17) (assign (added_parameter_aut a15 integer S17) (variable_value v15)))
	)

	(:action add_parameter_a15_S17_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a15 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a15 ?s2) (has_constraint a15 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S17 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S17 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S17 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S17 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S17) (assign (added_parameter_aut a15 integer S17) (variable_value v30)))
	)

	(:action add_parameter_a15_S17_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a15 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a15 ?s2) (has_constraint a15 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S17 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S17 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S17 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S17 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S17) (assign (added_parameter_aut a15 integer S17) (variable_value v0)))
	)

	(:action add_parameter_a19_S3_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a19 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a19 ?s2) (has_constraint a19 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S3 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S3 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S3 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S3 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S3) (assign (added_parameter_aut a19 integer S3) (variable_value v30)))
	)

	(:action add_parameter_a19_S3_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a19 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a19 ?s2) (has_constraint a19 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S3 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S3 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S3 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S3 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S3) (assign (added_parameter_aut a19 integer S3) (variable_value v0)))
	)

	(:action add_parameter_a19_S3_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a19 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a19 ?s2) (has_constraint a19 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S3 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S3 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S3 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S3 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S3) (assign (added_parameter_aut a19 integer S3) (variable_value v15)))
	)

	(:action add_parameter_a19_S3_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a19 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a19 ?s2) (has_constraint a19 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S3 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S3 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S3 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S3 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S3) (assign (added_parameter_aut a19 integer S3) (variable_value v5)))
	)

	(:action add_parameter_a9_S3_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a9 categorical S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a9 ?s2) (has_constraint a9 categorical S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S3 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S3 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S3 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S3 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S3) (assign (added_parameter_aut a9 categorical S3) (variable_value c2)))
	)

	(:action add_parameter_a9_S3_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a9 categorical S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a9 ?s2) (has_constraint a9 categorical S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S3 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S3 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S3 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S3 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S3) (assign (added_parameter_aut a9 categorical S3) (variable_value c1)))
	)

	(:action add_parameter_a9_S3_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a9 categorical S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a9 ?s2) (has_constraint a9 categorical S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S3 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S3 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S3 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S3 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S3) (assign (added_parameter_aut a9 categorical S3) (variable_value c3)))
	)

	(:action add_parameter_a3_sDEC1_1_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a3 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a3 ?s2) (has_constraint a3 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer sDEC1_1 ?s2)) (< (variable_value v15) (minority_constraint a3 integer sDEC1_1 ?s2)) (= (variable_value v15) (equality_constraint a3 integer sDEC1_1 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer sDEC1_1 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer sDEC1_1) (assign (added_parameter_aut a3 integer sDEC1_1) (variable_value v15)))
	)

	(:action add_parameter_a18_S5_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a18 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a18 ?s2) (has_constraint a18 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S5 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S5 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S5 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S5 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S5) (assign (added_parameter_aut a18 integer S5) (variable_value v15)))
	)

	(:action add_parameter_a11_S4_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a11 categorical S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a11 ?s2) (has_constraint a11 categorical S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S4 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S4 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S4 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S4 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S4) (assign (added_parameter_aut a11 categorical S4) (variable_value c1)))
	)

	(:action add_parameter_a12_sDEC1_2_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a12 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a12 ?s2) (has_constraint a12 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer sDEC1_2 ?s2)) (< (variable_value v5) (minority_constraint a12 integer sDEC1_2 ?s2)) (= (variable_value v5) (equality_constraint a12 integer sDEC1_2 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer sDEC1_2 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer sDEC1_2) (assign (added_parameter_aut a12 integer sDEC1_2) (variable_value v5)))
	)

	(:action add_parameter_a3_sDEC1_1_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a3 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a3 ?s2) (has_constraint a3 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer sDEC1_1 ?s2)) (< (variable_value v30) (minority_constraint a3 integer sDEC1_1 ?s2)) (= (variable_value v30) (equality_constraint a3 integer sDEC1_1 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer sDEC1_1 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer sDEC1_1) (assign (added_parameter_aut a3 integer sDEC1_1) (variable_value v30)))
	)

	(:action add_parameter_a18_S5_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a18 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a18 ?s2) (has_constraint a18 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S5 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S5 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S5 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S5 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S5) (assign (added_parameter_aut a18 integer S5) (variable_value v5)))
	)

	(:action add_parameter_a12_sDEC1_2_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a12 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a12 ?s2) (has_constraint a12 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer sDEC1_2 ?s2)) (< (variable_value v0) (minority_constraint a12 integer sDEC1_2 ?s2)) (= (variable_value v0) (equality_constraint a12 integer sDEC1_2 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer sDEC1_2 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer sDEC1_2) (assign (added_parameter_aut a12 integer sDEC1_2) (variable_value v0)))
	)

	(:action add_parameter_a12_sDEC1_2_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a12 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a12 ?s2) (has_constraint a12 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer sDEC1_2 ?s2)) (< (variable_value v15) (minority_constraint a12 integer sDEC1_2 ?s2)) (= (variable_value v15) (equality_constraint a12 integer sDEC1_2 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer sDEC1_2 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer sDEC1_2) (assign (added_parameter_aut a12 integer sDEC1_2) (variable_value v15)))
	)

	(:action add_parameter_a3_sDEC1_1_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a3 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a3 ?s2) (has_constraint a3 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer sDEC1_1 ?s2)) (< (variable_value v0) (minority_constraint a3 integer sDEC1_1 ?s2)) (= (variable_value v0) (equality_constraint a3 integer sDEC1_1 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer sDEC1_1 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer sDEC1_1) (assign (added_parameter_aut a3 integer sDEC1_1) (variable_value v0)))
	)

	(:action add_parameter_a11_S4_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a11 categorical S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a11 ?s2) (has_constraint a11 categorical S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S4 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S4 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S4 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S4 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S4) (assign (added_parameter_aut a11 categorical S4) (variable_value c2)))
	)

	(:action add_parameter_a11_S4_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a11 categorical S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a11 ?s2) (has_constraint a11 categorical S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S4 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S4 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S4 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S4 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S4) (assign (added_parameter_aut a11 categorical S4) (variable_value c3)))
	)

	(:action add_parameter_a12_sDEC1_2_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a12 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a12 ?s2) (has_constraint a12 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer sDEC1_2 ?s2)) (< (variable_value v30) (minority_constraint a12 integer sDEC1_2 ?s2)) (= (variable_value v30) (equality_constraint a12 integer sDEC1_2 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer sDEC1_2 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer sDEC1_2) (assign (added_parameter_aut a12 integer sDEC1_2) (variable_value v30)))
	)

	(:action add_parameter_a3_sDEC1_1_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a3 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a3 ?s2) (has_constraint a3 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer sDEC1_1 ?s2)) (< (variable_value v5) (minority_constraint a3 integer sDEC1_1 ?s2)) (= (variable_value v5) (equality_constraint a3 integer sDEC1_1 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer sDEC1_1 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer sDEC1_1) (assign (added_parameter_aut a3 integer sDEC1_1) (variable_value v5)))
	)

	(:action add_parameter_a18_S5_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a18 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a18 ?s2) (has_constraint a18 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S5 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S5 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S5 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S5 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S5) (assign (added_parameter_aut a18 integer S5) (variable_value v30)))
	)

	(:action add_parameter_a18_S5_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a18 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a18 ?s2) (has_constraint a18 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S5 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S5 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S5 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S5 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S5) (assign (added_parameter_aut a18 integer S5) (variable_value v0)))
	)

	(:action add_parameter_a1_S18_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a1 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a1 ?s2) (has_constraint a1 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S18 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S18 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S18 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S18 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S18) (assign (added_parameter_aut a1 integer S18) (variable_value v15)))
	)

	(:action add_parameter_a1_S18_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a1 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a1 ?s2) (has_constraint a1 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S18 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S18 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S18 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S18 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S18) (assign (added_parameter_aut a1 integer S18) (variable_value v0)))
	)

	(:action add_parameter_a2_S16_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a2 categorical S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a2 ?s2) (has_constraint a2 categorical S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S16 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S16 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S16 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S16 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S16) (assign (added_parameter_aut a2 categorical S16) (variable_value c1)))
	)

	(:action add_parameter_a10_S16_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a10 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a10 ?s2) (has_constraint a10 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S16 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S16 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S16 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S16 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S16) (assign (added_parameter_aut a10 integer S16) (variable_value v15)))
	)

	(:action add_parameter_a1_S18_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a1 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a1 ?s2) (has_constraint a1 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S18 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S18 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S18 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S18 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S18) (assign (added_parameter_aut a1 integer S18) (variable_value v5)))
	)

	(:action add_parameter_a6_S10_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a6 categorical S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a6 ?s2) (has_constraint a6 categorical S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S10 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S10 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S10 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S10 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S10) (assign (added_parameter_aut a6 categorical S10) (variable_value c3)))
	)

	(:action add_parameter_a10_S16_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a10 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a10 ?s2) (has_constraint a10 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S16 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S16 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S16 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S16 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S16) (assign (added_parameter_aut a10 integer S16) (variable_value v5)))
	)

	(:action add_parameter_a6_S10_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a6 categorical S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a6 ?s2) (has_constraint a6 categorical S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S10 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S10 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S10 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S10 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S10) (assign (added_parameter_aut a6 categorical S10) (variable_value c2)))
	)

	(:action add_parameter_a10_S16_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a10 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a10 ?s2) (has_constraint a10 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S16 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S16 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S16 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S16 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S16) (assign (added_parameter_aut a10 integer S16) (variable_value v0)))
	)

	(:action add_parameter_a6_S10_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a6 categorical S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a6 ?s2) (has_constraint a6 categorical S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S10 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S10 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S10 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S10 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S10) (assign (added_parameter_aut a6 categorical S10) (variable_value c1)))
	)

	(:action add_parameter_a10_S16_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a10 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a10 ?s2) (has_constraint a10 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S16 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S16 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S16 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S16 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S16) (assign (added_parameter_aut a10 integer S16) (variable_value v30)))
	)

	(:action add_parameter_a2_S16_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a2 categorical S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a2 ?s2) (has_constraint a2 categorical S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S16 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S16 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S16 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S16 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S16) (assign (added_parameter_aut a2 categorical S16) (variable_value c2)))
	)

	(:action add_parameter_a3_S14_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a3 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a3 ?s2) (has_constraint a3 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S14 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S14 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S14 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S14 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S14) (assign (added_parameter_aut a3 integer S14) (variable_value v30)))
	)

	(:action add_parameter_a16_S9_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a16 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a16 ?s2) (has_constraint a16 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S9 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S9 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S9 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S9 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S9) (assign (added_parameter_aut a16 integer S9) (variable_value v5)))
	)

	(:action add_parameter_a2_S3_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a2 categorical S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a2 ?s2) (has_constraint a2 categorical S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S3 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S3 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S3 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S3 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S3) (assign (added_parameter_aut a2 categorical S3) (variable_value c1)))
	)

	(:action add_parameter_a10_S3_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a10 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a10 ?s2) (has_constraint a10 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S3 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S3 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S3 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S3 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S3) (assign (added_parameter_aut a10 integer S3) (variable_value v5)))
	)

	(:action add_parameter_a1_S4_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a1 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a1 ?s2) (has_constraint a1 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S4 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S4 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S4 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S4 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S4) (assign (added_parameter_aut a1 integer S4) (variable_value v15)))
	)

	(:action add_parameter_a1_S4_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a1 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a1 ?s2) (has_constraint a1 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S4 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S4 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S4 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S4 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S4) (assign (added_parameter_aut a1 integer S4) (variable_value v5)))
	)

	(:action add_parameter_a10_S3_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a10 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a10 ?s2) (has_constraint a10 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S3 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S3 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S3 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S3 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S3) (assign (added_parameter_aut a10 integer S3) (variable_value v30)))
	)

	(:action add_parameter_a2_S3_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a2 categorical S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a2 ?s2) (has_constraint a2 categorical S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S3 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S3 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S3 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S3 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S3) (assign (added_parameter_aut a2 categorical S3) (variable_value c2)))
	)

	(:action add_parameter_a10_S3_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a10 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a10 ?s2) (has_constraint a10 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S3 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S3 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S3 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S3 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S3) (assign (added_parameter_aut a10 integer S3) (variable_value v15)))
	)

	(:action add_parameter_a10_S3_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a10 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a10 ?s2) (has_constraint a10 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S3 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S3 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S3 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S3 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S3) (assign (added_parameter_aut a10 integer S3) (variable_value v0)))
	)

	(:action add_parameter_a2_S3_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a2 categorical S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a2 ?s2) (has_constraint a2 categorical S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S3 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S3 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S3 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S3 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S3) (assign (added_parameter_aut a2 categorical S3) (variable_value c3)))
	)

	(:action add_parameter_a1_S4_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a1 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a1 ?s2) (has_constraint a1 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S4 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S4 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S4 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S4 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S4) (assign (added_parameter_aut a1 integer S4) (variable_value v0)))
	)

	(:action add_parameter_a1_S4_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a1 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a1 ?s2) (has_constraint a1 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S4 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S4 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S4 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S4 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S4) (assign (added_parameter_aut a1 integer S4) (variable_value v30)))
	)

	(:action add_parameter_a12_S12_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a12 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a12 ?s2) (has_constraint a12 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S12 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S12 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S12 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S12 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S12) (assign (added_parameter_aut a12 integer S12) (variable_value v5)))
	)

	(:action add_parameter_a3_S14_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a3 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a3 ?s2) (has_constraint a3 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S14 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S14 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S14 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S14 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S14) (assign (added_parameter_aut a3 integer S14) (variable_value v5)))
	)

	(:action add_parameter_a16_S9_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a16 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a16 ?s2) (has_constraint a16 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S9 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S9 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S9 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S9 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S9) (assign (added_parameter_aut a16 integer S9) (variable_value v15)))
	)

	(:action add_parameter_a12_S12_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a12 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a12 ?s2) (has_constraint a12 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S12 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S12 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S12 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S12 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S12) (assign (added_parameter_aut a12 integer S12) (variable_value v15)))
	)

	(:action add_parameter_a3_S14_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a3 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a3 ?s2) (has_constraint a3 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S14 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S14 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S14 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S14 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S14) (assign (added_parameter_aut a3 integer S14) (variable_value v0)))
	)

	(:action add_parameter_a16_S9_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a16 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a16 ?s2) (has_constraint a16 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S9 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S9 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S9 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S9 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S9) (assign (added_parameter_aut a16 integer S9) (variable_value v0)))
	)

	(:action add_parameter_a3_S14_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a3 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a3 ?s2) (has_constraint a3 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S14 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S14 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S14 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S14 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S14) (assign (added_parameter_aut a3 integer S14) (variable_value v15)))
	)

	(:action add_parameter_a16_S9_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a16 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a16 ?s2) (has_constraint a16 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S9 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S9 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S9 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S9 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S9) (assign (added_parameter_aut a16 integer S9) (variable_value v30)))
	)

	(:action add_parameter_a12_S12_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a12 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a12 ?s2) (has_constraint a12 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S12 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S12 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S12 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S12 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S12) (assign (added_parameter_aut a12 integer S12) (variable_value v30)))
	)

	(:action add_parameter_a12_S12_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a12 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a12 ?s2) (has_constraint a12 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S12 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S12 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S12 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S12 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S12) (assign (added_parameter_aut a12 integer S12) (variable_value v0)))
	)

	(:action add_parameter_a6_S13_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a6 categorical S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a6 ?s2) (has_constraint a6 categorical S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S13 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S13 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S13 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S13 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S13) (assign (added_parameter_aut a6 categorical S13) (variable_value c3)))
	)

	(:action add_parameter_a19_S17_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a19 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a19 ?s2) (has_constraint a19 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S17 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S17 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S17 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S17 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S17) (assign (added_parameter_aut a19 integer S17) (variable_value v5)))
	)

	(:action add_parameter_a19_S17_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a19 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a19 ?s2) (has_constraint a19 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S17 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S17 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S17 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S17 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S17) (assign (added_parameter_aut a19 integer S17) (variable_value v30)))
	)

	(:action add_parameter_a19_S17_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a19 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a19 ?s2) (has_constraint a19 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S17 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S17 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S17 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S17 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S17) (assign (added_parameter_aut a19 integer S17) (variable_value v0)))
	)

	(:action add_parameter_a19_S17_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a19 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a19 ?s2) (has_constraint a19 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S17 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S17 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S17 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S17 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S17) (assign (added_parameter_aut a19 integer S17) (variable_value v15)))
	)

	(:action add_parameter_a9_S17_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a9 categorical S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a9 ?s2) (has_constraint a9 categorical S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S17 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S17 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S17 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S17 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S17) (assign (added_parameter_aut a9 categorical S17) (variable_value c1)))
	)

	(:action add_parameter_a15_S15_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a15 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a15 ?s2) (has_constraint a15 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S15 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S15 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S15 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S15 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S15) (assign (added_parameter_aut a15 integer S15) (variable_value v5)))
	)

	(:action add_parameter_a9_S17_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a9 categorical S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a9 ?s2) (has_constraint a9 categorical S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S17 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S17 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S17 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S17 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S17) (assign (added_parameter_aut a9 categorical S17) (variable_value c2)))
	)

	(:action add_parameter_a15_S15_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a15 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a15 ?s2) (has_constraint a15 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S15 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S15 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S15 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S15 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S15) (assign (added_parameter_aut a15 integer S15) (variable_value v15)))
	)

	(:action add_parameter_a15_S15_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a15 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a15 ?s2) (has_constraint a15 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S15 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S15 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S15 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S15 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S15) (assign (added_parameter_aut a15 integer S15) (variable_value v30)))
	)

	(:action add_parameter_a9_S17_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a9 categorical S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a9 ?s2) (has_constraint a9 categorical S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S17 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S17 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S17 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S17 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S17) (assign (added_parameter_aut a9 categorical S17) (variable_value c3)))
	)

	(:action add_parameter_a15_S15_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a15 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a15 ?s2) (has_constraint a15 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S15 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S15 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S15 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S15 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S15) (assign (added_parameter_aut a15 integer S15) (variable_value v0)))
	)

	(:action add_parameter_a10_S12_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a10 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a10 ?s2) (has_constraint a10 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S12 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S12 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S12 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S12 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S12) (assign (added_parameter_aut a10 integer S12) (variable_value v5)))
	)

	(:action add_action_a7_R2
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a7)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a7 R2) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a7 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a7 R2)) (after_add) (complete_sync a7))
	)

	(:action add_action_a7_R0
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a7)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a7 R0) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a7 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a7 R0)) (after_add) (complete_sync a7))
	)

	(:action add_action_a7_R1
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a7)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a7 R1) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a7 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a7 R1)) (after_add) (complete_sync a7))
	)

	(:action add_parameter_a18_S4_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a18 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a18 ?s2) (has_constraint a18 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S4 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S4 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S4 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S4 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S4) (assign (added_parameter_aut a18 integer S4) (variable_value v30)))
	)

	(:action add_parameter_a18_S4_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a18 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a18 ?s2) (has_constraint a18 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S4 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S4 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S4 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S4 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S4) (assign (added_parameter_aut a18 integer S4) (variable_value v0)))
	)

	(:action add_parameter_a18_S4_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a18 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a18 ?s2) (has_constraint a18 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S4 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S4 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S4 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S4 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S4) (assign (added_parameter_aut a18 integer S4) (variable_value v15)))
	)

	(:action add_parameter_a11_S2_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a11 categorical S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a11 ?s2) (has_constraint a11 categorical S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S2 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S2 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S2 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S2 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S2) (assign (added_parameter_aut a11 categorical S2) (variable_value c1)))
	)

	(:action add_parameter_a18_S4_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a18 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a18 ?s2) (has_constraint a18 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S4 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S4 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S4 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S4 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S4) (assign (added_parameter_aut a18 integer S4) (variable_value v5)))
	)

	(:action add_parameter_a11_S2_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a11 categorical S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a11 ?s2) (has_constraint a11 categorical S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S2 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S2 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S2 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S2 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S2) (assign (added_parameter_aut a11 categorical S2) (variable_value c3)))
	)

	(:action add_parameter_a6_S9_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a6 categorical S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a6 ?s2) (has_constraint a6 categorical S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S9 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S9 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S9 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S9 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S9) (assign (added_parameter_aut a6 categorical S9) (variable_value c2)))
	)

	(:action add_parameter_a1_S14_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a1 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a1 ?s2) (has_constraint a1 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S14 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S14 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S14 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S14 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S14) (assign (added_parameter_aut a1 integer S14) (variable_value v30)))
	)

	(:action add_parameter_a10_S12_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a10 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a10 ?s2) (has_constraint a10 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S12 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S12 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S12 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S12 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S12) (assign (added_parameter_aut a10 integer S12) (variable_value v0)))
	)

	(:action add_parameter_a10_S12_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a10 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a10 ?s2) (has_constraint a10 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S12 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S12 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S12 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S12 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S12) (assign (added_parameter_aut a10 integer S12) (variable_value v30)))
	)

	(:action add_parameter_a1_S14_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a1 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a1 ?s2) (has_constraint a1 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S14 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S14 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S14 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S14 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S14) (assign (added_parameter_aut a1 integer S14) (variable_value v15)))
	)

	(:action add_parameter_a1_S14_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a1 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a1 ?s2) (has_constraint a1 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S14 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S14 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S14 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S14 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S14) (assign (added_parameter_aut a1 integer S14) (variable_value v0)))
	)

	(:action add_parameter_a6_S9_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a6 categorical S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a6 ?s2) (has_constraint a6 categorical S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S9 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S9 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S9 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S9 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S9) (assign (added_parameter_aut a6 categorical S9) (variable_value c1)))
	)

	(:action add_parameter_a2_S12_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a2 categorical S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a2 ?s2) (has_constraint a2 categorical S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S12 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S12 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S12 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S12 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S12) (assign (added_parameter_aut a2 categorical S12) (variable_value c3)))
	)

	(:action add_parameter_a10_S12_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a10 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a10 ?s2) (has_constraint a10 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S12 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S12 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S12 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S12 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S12) (assign (added_parameter_aut a10 integer S12) (variable_value v15)))
	)

	(:action add_parameter_a1_S14_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a1 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a1 ?s2) (has_constraint a1 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S14 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S14 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S14 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S14 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S14) (assign (added_parameter_aut a1 integer S14) (variable_value v5)))
	)

	(:action add_parameter_a2_S12_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a2 categorical S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a2 ?s2) (has_constraint a2 categorical S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S12 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S12 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S12 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S12 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S12) (assign (added_parameter_aut a2 categorical S12) (variable_value c2)))
	)

	(:action add_parameter_a2_S12_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a2 categorical S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a2 ?s2) (has_constraint a2 categorical S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S12 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S12 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S12 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S12 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S12) (assign (added_parameter_aut a2 categorical S12) (variable_value c1)))
	)

	(:action add_parameter_a6_S9_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a6 categorical S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a6 ?s2) (has_constraint a6 categorical S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S9 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S9 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S9 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S9 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S9) (assign (added_parameter_aut a6 categorical S9) (variable_value c3)))
	)

	(:action add_action_a6_R2
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a6)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a6 R2) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a6 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a6 R2)) (after_add) (complete_sync a6))
	)

	(:action add_action_a6_R0
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a6)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a6 R0) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a6 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a6 R0)) (after_add) (complete_sync a6))
	)

	(:action add_action_a6_R1
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a6)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a6 R1) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a6 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a6 R1)) (after_add) (complete_sync a6))
	)

	(:action add_parameter_a11_S2_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a11 categorical S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a11 ?s2) (has_constraint a11 categorical S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S2 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S2 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S2 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S2 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S2) (assign (added_parameter_aut a11 categorical S2) (variable_value c2)))
	)

	(:action add_move_automata_a18
		:parameters ()
		:precondition (and (complete_sync a18) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a18 ?s2)) (cur_s_state ?s1) (automaton ?s1 a18 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a18 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a18 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a18 ?s2)) (automaton ?s1 a18 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a18 ?pn ?s1) (not (has_added_parameter_aut a18 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a18 ?s2) (invalid ?s1 a18 ?s2) ) (not (invalid ?s1 a18 ?s2)) ) ) (not (complete_sync a18)) ) 
	)

	(:action add_move_automata_a19
		:parameters ()
		:precondition (and (complete_sync a19) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a19 ?s2)) (cur_s_state ?s1) (automaton ?s1 a19 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a19 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a19 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a19 ?s2)) (automaton ?s1 a19 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a19 ?pn ?s1) (not (has_added_parameter_aut a19 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a19 ?s2) (invalid ?s1 a19 ?s2) ) (not (invalid ?s1 a19 ?s2)) ) ) (not (complete_sync a19)) ) 
	)

	(:action add_move_automata_a16
		:parameters ()
		:precondition (and (complete_sync a16) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a16 ?s2)) (cur_s_state ?s1) (automaton ?s1 a16 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a16 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a16 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a16 ?s2)) (automaton ?s1 a16 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a16 ?pn ?s1) (not (has_added_parameter_aut a16 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a16 ?s2) (invalid ?s1 a16 ?s2) ) (not (invalid ?s1 a16 ?s2)) ) ) (not (complete_sync a16)) ) 
	)

	(:action add_move_automata_a17
		:parameters ()
		:precondition (and (complete_sync a17) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a17 ?s2)) (cur_s_state ?s1) (automaton ?s1 a17 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a17 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a17 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a17 ?s2)) (automaton ?s1 a17 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a17 ?pn ?s1) (not (has_added_parameter_aut a17 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a17 ?s2) (invalid ?s1 a17 ?s2) ) (not (invalid ?s1 a17 ?s2)) ) ) (not (complete_sync a17)) ) 
	)

	(:action add_action_a9_R2
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a9)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a9 R2) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a9 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a9 R2)) (after_add) (complete_sync a9))
	)

	(:action add_move_automata_a14
		:parameters ()
		:precondition (and (complete_sync a14) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a14 ?s2)) (cur_s_state ?s1) (automaton ?s1 a14 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a14 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a14 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a14 ?s2)) (automaton ?s1 a14 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a14 ?pn ?s1) (not (has_added_parameter_aut a14 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a14 ?s2) (invalid ?s1 a14 ?s2) ) (not (invalid ?s1 a14 ?s2)) ) ) (not (complete_sync a14)) ) 
	)

	(:action add_parameter_a11_S18_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a11 categorical S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a11 ?s2) (has_constraint a11 categorical S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S18 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S18 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S18 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S18 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S18) (assign (added_parameter_aut a11 categorical S18) (variable_value c2)))
	)

	(:action add_action_a9_R0
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a9)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a9 R0) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a9 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a9 R0)) (after_add) (complete_sync a9))
	)

	(:action add_move_automata_a15
		:parameters ()
		:precondition (and (complete_sync a15) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a15 ?s2)) (cur_s_state ?s1) (automaton ?s1 a15 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a15 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a15 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a15 ?s2)) (automaton ?s1 a15 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a15 ?pn ?s1) (not (has_added_parameter_aut a15 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a15 ?s2) (invalid ?s1 a15 ?s2) ) (not (invalid ?s1 a15 ?s2)) ) ) (not (complete_sync a15)) ) 
	)

	(:action add_parameter_a16_S8_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a16 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a16 ?s2) (has_constraint a16 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S8 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S8 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S8 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S8 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S8) (assign (added_parameter_aut a16 integer S8) (variable_value v5)))
	)

	(:action add_move_automata_a12
		:parameters ()
		:precondition (and (complete_sync a12) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a12 ?s2)) (cur_s_state ?s1) (automaton ?s1 a12 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a12 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a12 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a12 ?s2)) (automaton ?s1 a12 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a12 ?pn ?s1) (not (has_added_parameter_aut a12 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a12 ?s2) (invalid ?s1 a12 ?s2) ) (not (invalid ?s1 a12 ?s2)) ) ) (not (complete_sync a12)) ) 
	)

	(:action add_parameter_a12_S13_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a12 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a12 ?s2) (has_constraint a12 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S13 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S13 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S13 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S13 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S13) (assign (added_parameter_aut a12 integer S13) (variable_value v5)))
	)

	(:action add_move_automata_a13
		:parameters ()
		:precondition (and (complete_sync a13) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a13 ?s2)) (cur_s_state ?s1) (automaton ?s1 a13 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a13 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a13 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a13 ?s2)) (automaton ?s1 a13 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a13 ?pn ?s1) (not (has_added_parameter_aut a13 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a13 ?s2) (invalid ?s1 a13 ?s2) ) (not (invalid ?s1 a13 ?s2)) ) ) (not (complete_sync a13)) ) 
	)

	(:action add_parameter_a16_S8_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a16 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a16 ?s2) (has_constraint a16 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S8 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S8 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S8 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S8 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S8) (assign (added_parameter_aut a16 integer S8) (variable_value v15)))
	)

	(:action add_move_automata_a7
		:parameters ()
		:precondition (and (complete_sync a7) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a7 ?s2)) (cur_s_state ?s1) (automaton ?s1 a7 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a7 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a7 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a7 ?s2)) (automaton ?s1 a7 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a7 ?pn ?s1) (not (has_added_parameter_aut a7 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a7 ?s2) (invalid ?s1 a7 ?s2) ) (not (invalid ?s1 a7 ?s2)) ) ) (not (complete_sync a7)) ) 
	)

	(:action add_parameter_a1_S2_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a1 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a1 ?s2) (has_constraint a1 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S2 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S2 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S2 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S2 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S2) (assign (added_parameter_aut a1 integer S2) (variable_value v0)))
	)

	(:action add_parameter_a10_S0_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a10 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a10 ?s2) (has_constraint a10 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S0 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S0 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S0 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S0 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S0) (assign (added_parameter_aut a10 integer S0) (variable_value v15)))
	)

	(:action add_move_automata_a6
		:parameters ()
		:precondition (and (complete_sync a6) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a6 ?s2)) (cur_s_state ?s1) (automaton ?s1 a6 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a6 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a6 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a6 ?s2)) (automaton ?s1 a6 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a6 ?pn ?s1) (not (has_added_parameter_aut a6 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a6 ?s2) (invalid ?s1 a6 ?s2) ) (not (invalid ?s1 a6 ?s2)) ) ) (not (complete_sync a6)) ) 
	)

	(:action add_parameter_a1_S2_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a1 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a1 ?s2) (has_constraint a1 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S2 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S2 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S2 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S2 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S2) (assign (added_parameter_aut a1 integer S2) (variable_value v30)))
	)

	(:action add_parameter_a10_S0_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a10 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a10 ?s2) (has_constraint a10 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S0 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S0 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S0 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S0 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S0) (assign (added_parameter_aut a10 integer S0) (variable_value v0)))
	)

	(:action add_move_automata_a5
		:parameters ()
		:precondition (and (complete_sync a5) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a5 ?s2)) (cur_s_state ?s1) (automaton ?s1 a5 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a5 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a5 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a5 ?s2)) (automaton ?s1 a5 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a5 ?pn ?s1) (not (has_added_parameter_aut a5 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a5 ?s2) (invalid ?s1 a5 ?s2) ) (not (invalid ?s1 a5 ?s2)) ) ) (not (complete_sync a5)) ) 
	)

	(:action add_parameter_a2_S0_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a2 categorical S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a2 ?s2) (has_constraint a2 categorical S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S0 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S0 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S0 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S0 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S0) (assign (added_parameter_aut a2 categorical S0) (variable_value c3)))
	)

	(:action add_parameter_a10_S0_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a10 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a10 ?s2) (has_constraint a10 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S0 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S0 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S0 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S0 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S0) (assign (added_parameter_aut a10 integer S0) (variable_value v5)))
	)

	(:action add_move_automata_a4
		:parameters ()
		:precondition (and (complete_sync a4) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a4 ?s2)) (cur_s_state ?s1) (automaton ?s1 a4 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a4 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a4 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a4 ?s2)) (automaton ?s1 a4 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a4 ?pn ?s1) (not (has_added_parameter_aut a4 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a4 ?s2) (invalid ?s1 a4 ?s2) ) (not (invalid ?s1 a4 ?s2)) ) ) (not (complete_sync a4)) ) 
	)

	(:action add_parameter_a1_S2_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a1 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a1 ?s2) (has_constraint a1 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S2 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S2 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S2 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S2 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S2) (assign (added_parameter_aut a1 integer S2) (variable_value v15)))
	)

	(:action add_move_automata_a3
		:parameters ()
		:precondition (and (complete_sync a3) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a3 ?s2)) (cur_s_state ?s1) (automaton ?s1 a3 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a3 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a3 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a3 ?s2)) (automaton ?s1 a3 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a3 ?pn ?s1) (not (has_added_parameter_aut a3 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a3 ?s2) (invalid ?s1 a3 ?s2) ) (not (invalid ?s1 a3 ?s2)) ) ) (not (complete_sync a3)) ) 
	)

	(:action add_parameter_a2_S0_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a2 categorical S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a2 ?s2) (has_constraint a2 categorical S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S0 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S0 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S0 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S0 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S0) (assign (added_parameter_aut a2 categorical S0) (variable_value c2)))
	)

	(:action add_move_automata_a2
		:parameters ()
		:precondition (and (complete_sync a2) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a2 ?s2)) (cur_s_state ?s1) (automaton ?s1 a2 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a2 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a2 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a2 ?s2)) (automaton ?s1 a2 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a2 ?pn ?s1) (not (has_added_parameter_aut a2 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a2 ?s2) (invalid ?s1 a2 ?s2) ) (not (invalid ?s1 a2 ?s2)) ) ) (not (complete_sync a2)) ) 
	)

	(:action add_parameter_a1_S2_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a1 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a1 ?s2) (has_constraint a1 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S2 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S2 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S2 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S2 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S2) (assign (added_parameter_aut a1 integer S2) (variable_value v5)))
	)

	(:action add_move_automata_a1
		:parameters ()
		:precondition (and (complete_sync a1) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a1 ?s2)) (cur_s_state ?s1) (automaton ?s1 a1 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a1 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a1 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a1 ?s2)) (automaton ?s1 a1 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a1 ?pn ?s1) (not (has_added_parameter_aut a1 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a1 ?s2) (invalid ?s1 a1 ?s2) ) (not (invalid ?s1 a1 ?s2)) ) ) (not (complete_sync a1)) ) 
	)

	(:action add_parameter_a10_S0_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a10 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a10 ?s2) (has_constraint a10 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S0 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S0 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S0 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S0 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S0) (assign (added_parameter_aut a10 integer S0) (variable_value v30)))
	)

	(:action add_parameter_a2_S0_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a2 categorical S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a2 ?s2) (has_constraint a2 categorical S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S0 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S0 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S0 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S0 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S0) (assign (added_parameter_aut a2 categorical S0) (variable_value c1)))
	)

	(:action add_move_automata_a0
		:parameters ()
		:precondition (and (complete_sync a0) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a0 ?s2)) (cur_s_state ?s1) (automaton ?s1 a0 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a0 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a0 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a0 ?s2)) (automaton ?s1 a0 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a0 ?pn ?s1) (not (has_added_parameter_aut a0 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a0 ?s2) (invalid ?s1 a0 ?s2) ) (not (invalid ?s1 a0 ?s2)) ) ) (not (complete_sync a0)) ) 
	)

	(:action add_move_automata_a10
		:parameters ()
		:precondition (and (complete_sync a10) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a10 ?s2)) (cur_s_state ?s1) (automaton ?s1 a10 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a10 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a10 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a10 ?s2)) (automaton ?s1 a10 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a10 ?pn ?s1) (not (has_added_parameter_aut a10 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a10 ?s2) (invalid ?s1 a10 ?s2) ) (not (invalid ?s1 a10 ?s2)) ) ) (not (complete_sync a10)) ) 
	)

	(:action add_parameter_a12_S13_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a12 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a12 ?s2) (has_constraint a12 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S13 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S13 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S13 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S13 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S13) (assign (added_parameter_aut a12 integer S13) (variable_value v15)))
	)

	(:action add_parameter_a3_S15_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a3 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a3 ?s2) (has_constraint a3 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S15 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S15 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S15 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S15 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S15) (assign (added_parameter_aut a3 integer S15) (variable_value v0)))
	)

	(:action add_parameter_a16_S8_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a16 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a16 ?s2) (has_constraint a16 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S8 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S8 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S8 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S8 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S8) (assign (added_parameter_aut a16 integer S8) (variable_value v0)))
	)

	(:action add_move_automata_a11
		:parameters ()
		:precondition (and (complete_sync a11) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a11 ?s2)) (cur_s_state ?s1) (automaton ?s1 a11 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a11 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a11 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a11 ?s2)) (automaton ?s1 a11 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a11 ?pn ?s1) (not (has_added_parameter_aut a11 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a11 ?s2) (invalid ?s1 a11 ?s2) ) (not (invalid ?s1 a11 ?s2)) ) ) (not (complete_sync a11)) ) 
	)

	(:action add_parameter_a3_S15_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a3 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a3 ?s2) (has_constraint a3 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S15 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S15 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S15 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S15 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S15) (assign (added_parameter_aut a3 integer S15) (variable_value v15)))
	)

	(:action add_parameter_a16_S8_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a16 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a16 ?s2) (has_constraint a16 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S8 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S8 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S8 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S8 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S8) (assign (added_parameter_aut a16 integer S8) (variable_value v30)))
	)

	(:action add_parameter_a12_S13_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a12 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a12 ?s2) (has_constraint a12 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S13 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S13 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S13 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S13 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S13) (assign (added_parameter_aut a12 integer S13) (variable_value v30)))
	)

	(:action add_parameter_a11_S18_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a11 categorical S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a11 ?s2) (has_constraint a11 categorical S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S18 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S18 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S18 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S18 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S18) (assign (added_parameter_aut a11 categorical S18) (variable_value c1)))
	)

	(:action add_parameter_a3_S15_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a3 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a3 ?s2) (has_constraint a3 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S15 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S15 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S15 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S15 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S15) (assign (added_parameter_aut a3 integer S15) (variable_value v30)))
	)

	(:action add_parameter_a12_S13_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a12 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a12 ?s2) (has_constraint a12 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S13 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S13 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S13 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S13 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S13) (assign (added_parameter_aut a12 integer S13) (variable_value v0)))
	)

	(:action add_parameter_a11_S18_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a11 categorical S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a11 ?s2) (has_constraint a11 categorical S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S18 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S18 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S18 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S18 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S18) (assign (added_parameter_aut a11 categorical S18) (variable_value c3)))
	)

	(:action add_parameter_a3_S15_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a3 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a3 ?s2) (has_constraint a3 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S15 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S15 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S15 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S15 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S15) (assign (added_parameter_aut a3 integer S15) (variable_value v5)))
	)

	(:action add_parameter_a2_S16_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a2 categorical S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a2 ?s2) (has_constraint a2 categorical S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S16 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S16 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S16 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S16 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S16) (assign (added_parameter_aut a2 categorical S16) (variable_value c3)))
	)

	(:action add_action_a8_R0
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a8)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a8 R0) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a8 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a8 R0)) (after_add) (complete_sync a8))
	)

	(:action add_parameter_a1_S18_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a1 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a1 ?s2) (has_constraint a1 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S18 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S18 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S18 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S18 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S18) (assign (added_parameter_aut a1 integer S18) (variable_value v30)))
	)

	(:action add_parameter_a15_S1_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a15 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a15 ?s2) (has_constraint a15 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S1 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S1 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S1 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S1 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S1) (assign (added_parameter_aut a15 integer S1) (variable_value v5)))
	)

	(:action add_parameter_a19_S7_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a19 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a19 ?s2) (has_constraint a19 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S7 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S7 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S7 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S7 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S7) (assign (added_parameter_aut a19 integer S7) (variable_value v15)))
	)

	(:action add_parameter_a19_S7_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a19 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a19 ?s2) (has_constraint a19 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S7 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S7 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S7 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S7 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S7) (assign (added_parameter_aut a19 integer S7) (variable_value v5)))
	)

	(:action add_parameter_a9_S7_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a9 categorical S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a9 ?s2) (has_constraint a9 categorical S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S7 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S7 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S7 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S7 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S7) (assign (added_parameter_aut a9 categorical S7) (variable_value c2)))
	)

	(:action add_move_automata_a9
		:parameters ()
		:precondition (and (complete_sync a9) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a9 ?s2)) (cur_s_state ?s1) (automaton ?s1 a9 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a9 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a9 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a9 ?s2)) (automaton ?s1 a9 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a9 ?pn ?s1) (not (has_added_parameter_aut a9 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a9 ?s2) (invalid ?s1 a9 ?s2) ) (not (invalid ?s1 a9 ?s2)) ) ) (not (complete_sync a9)) ) 
	)

	(:action add_parameter_a19_S7_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a19 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a19 ?s2) (has_constraint a19 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S7 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S7 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S7 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S7 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S7) (assign (added_parameter_aut a19 integer S7) (variable_value v30)))
	)

	(:action add_move_automata_a8
		:parameters ()
		:precondition (and (complete_sync a8) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (not (goal_state ?s1)) (not (invalid ?s1 a8 ?s2)) (cur_s_state ?s1) (automaton ?s1 a8 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) 0) (not (after_add_check)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a8 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) (not (invalid ?s1 a8 ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a8 ?s2)) (automaton ?s1 a8 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?pn - parameter_name) (when (has_added_parameter_aut a8 ?pn ?s1) (not (has_added_parameter_aut a8 ?pn ?s1))) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 a8 ?s2) (invalid ?s1 a8 ?s2) ) (not (invalid ?s1 a8 ?s2)) ) ) (not (complete_sync a8)) ) 
	)

	(:action add_parameter_a19_S7_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a19 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a19 ?s2) (has_constraint a19 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S7 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S7 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S7 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S7 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S7) (assign (added_parameter_aut a19 integer S7) (variable_value v0)))
	)

	(:action add_parameter_a15_S1_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a15 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a15 ?s2) (has_constraint a15 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S1 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S1 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S1 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S1 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S1) (assign (added_parameter_aut a15 integer S1) (variable_value v15)))
	)

	(:action add_parameter_a9_S7_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a9 categorical S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a9 ?s2) (has_constraint a9 categorical S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S7 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S7 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S7 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S7 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S7) (assign (added_parameter_aut a9 categorical S7) (variable_value c1)))
	)

	(:action add_parameter_a15_S1_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a15 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a15 ?s2) (has_constraint a15 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S1 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S1 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S1 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S1 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S1) (assign (added_parameter_aut a15 integer S1) (variable_value v30)))
	)

	(:action add_parameter_a15_S1_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a15 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a15 ?s2) (has_constraint a15 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S1 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S1 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S1 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S1 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S1) (assign (added_parameter_aut a15 integer S1) (variable_value v0)))
	)

	(:action add_parameter_a9_S7_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a9 categorical S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a9 ?s2) (has_constraint a9 categorical S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S7 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S7 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S7 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S7 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S7) (assign (added_parameter_aut a9 categorical S7) (variable_value c3)))
	)

	(:action add_parameter_a11_S8_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a11 categorical S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a11 ?s2) (has_constraint a11 categorical S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S8 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S8 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S8 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S8 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S8) (assign (added_parameter_aut a11 categorical S8) (variable_value c3)))
	)

	(:action add_parameter_a12_S3_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a12 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a12 ?s2) (has_constraint a12 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S3 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S3 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S3 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S3 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S3) (assign (added_parameter_aut a12 integer S3) (variable_value v30)))
	)

	(:action add_parameter_a3_S4_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a3 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a3 ?s2) (has_constraint a3 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S4 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S4 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S4 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S4 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S4) (assign (added_parameter_aut a3 integer S4) (variable_value v5)))
	)

	(:action add_action_a3_R0
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a3)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a3 R0) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a3 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a3 R0)) (after_add) (complete_sync a3))
	)

	(:action add_action_a3_R1
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a3)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a3 R1) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a3 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a3 R1)) (after_add) (complete_sync a3))
	)

	(:action add_parameter_a11_S8_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a11 categorical S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a11 ?s2) (has_constraint a11 categorical S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S8 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S8 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S8 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S8 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S8) (assign (added_parameter_aut a11 categorical S8) (variable_value c1)))
	)

	(:action add_parameter_a12_S3_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a12 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a12 ?s2) (has_constraint a12 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S3 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S3 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S3 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S3 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S3) (assign (added_parameter_aut a12 integer S3) (variable_value v5)))
	)

	(:action add_parameter_a12_S3_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a12 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a12 ?s2) (has_constraint a12 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S3 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S3 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S3 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S3 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S3) (assign (added_parameter_aut a12 integer S3) (variable_value v0)))
	)

	(:action add_parameter_a12_S3_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a12 integer S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a12 ?s2) (has_constraint a12 integer S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S3 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S3 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S3 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S3 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S3) (assign (added_parameter_aut a12 integer S3) (variable_value v15)))
	)

	(:action add_parameter_a11_S8_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a11 categorical S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a11 ?s2) (has_constraint a11 categorical S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S8 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S8 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S8 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S8 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S8) (assign (added_parameter_aut a11 categorical S8) (variable_value c2)))
	)

	(:action add_parameter_a18_S9_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a18 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a18 ?s2) (has_constraint a18 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S9 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S9 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S9 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S9 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S9) (assign (added_parameter_aut a18 integer S9) (variable_value v30)))
	)

	(:action add_parameter_a18_S9_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a18 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a18 ?s2) (has_constraint a18 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S9 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S9 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S9 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S9 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S9) (assign (added_parameter_aut a18 integer S9) (variable_value v0)))
	)

	(:action add_parameter_a3_S4_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a3 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a3 ?s2) (has_constraint a3 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S4 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S4 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S4 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S4 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S4) (assign (added_parameter_aut a3 integer S4) (variable_value v15)))
	)

	(:action add_parameter_a18_S9_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a18 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a18 ?s2) (has_constraint a18 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S9 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S9 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S9 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S9 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S9) (assign (added_parameter_aut a18 integer S9) (variable_value v15)))
	)

	(:action add_parameter_a3_S4_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a3 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a3 ?s2) (has_constraint a3 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S4 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S4 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S4 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S4 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S4) (assign (added_parameter_aut a3 integer S4) (variable_value v30)))
	)

	(:action add_parameter_a18_S9_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a18 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a18 ?s2) (has_constraint a18 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S9 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S9 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S9 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S9 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S9) (assign (added_parameter_aut a18 integer S9) (variable_value v5)))
	)

	(:action add_parameter_a3_S4_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a3 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a3 ?s2) (has_constraint a3 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S4 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S4 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S4 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S4 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S4) (assign (added_parameter_aut a3 integer S4) (variable_value v0)))
	)

	(:action add_parameter_a6_S12_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a6 categorical S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a6 ?s2) (has_constraint a6 categorical S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S12 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S12 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S12 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S12 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S12) (assign (added_parameter_aut a6 categorical S12) (variable_value c2)))
	)

	(:action add_parameter_a6_S12_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a6 categorical S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a6 ?s2) (has_constraint a6 categorical S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S12 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S12 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S12 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S12 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S12) (assign (added_parameter_aut a6 categorical S12) (variable_value c1)))
	)

	(:action add_parameter_a15_S2_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a15 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a15 ?s2) (has_constraint a15 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S2 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S2 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S2 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S2 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S2) (assign (added_parameter_aut a15 integer S2) (variable_value v30)))
	)

	(:action add_action_a2_R2
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a2)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a2 R2) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a2 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a2 R2)) (after_add) (complete_sync a2))
	)

	(:action add_parameter_a15_S2_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a15 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a15 ?s2) (has_constraint a15 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S2 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S2 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S2 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S2 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S2) (assign (added_parameter_aut a15 integer S2) (variable_value v5)))
	)

	(:action add_parameter_a15_S2_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a15 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a15 ?s2) (has_constraint a15 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S2 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S2 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S2 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S2 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S2) (assign (added_parameter_aut a15 integer S2) (variable_value v0)))
	)

	(:action add_parameter_a15_S2_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a15 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a15 ?s2) (has_constraint a15 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S2 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S2 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S2 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S2 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S2) (assign (added_parameter_aut a15 integer S2) (variable_value v15)))
	)

	(:action add_parameter_a10_S7_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a10 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a10 ?s2) (has_constraint a10 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S7 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S7 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S7 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S7 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S7) (assign (added_parameter_aut a10 integer S7) (variable_value v30)))
	)

	(:action add_parameter_a9_S1_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a9 categorical S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a9 ?s2) (has_constraint a9 categorical S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S1 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S1 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S1 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S1 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S1) (assign (added_parameter_aut a9 categorical S1) (variable_value c3)))
	)

	(:action add_parameter_a10_S7_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a10 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a10 ?s2) (has_constraint a10 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S7 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S7 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S7 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S7 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S7) (assign (added_parameter_aut a10 integer S7) (variable_value v15)))
	)

	(:action add_parameter_a10_S7_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a10 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a10 ?s2) (has_constraint a10 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S7 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S7 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S7 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S7 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S7) (assign (added_parameter_aut a10 integer S7) (variable_value v0)))
	)

	(:action add_action_a5_R2
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a5)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a5 R2) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a5 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a5 R2)) (after_add) (complete_sync a5))
	)

	(:action add_action_a5_R0
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a5)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a5 R0) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a5 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a5 R0)) (after_add) (complete_sync a5))
	)

	(:action add_action_a5_R1
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a5)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a5 R1) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a5 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a5 R1)) (after_add) (complete_sync a5))
	)

	(:action add_parameter_a2_S7_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a2 categorical S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a2 ?s2) (has_constraint a2 categorical S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S7 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S7 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S7 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S7 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S7) (assign (added_parameter_aut a2 categorical S7) (variable_value c2)))
	)

	(:action add_parameter_a6_S0_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a6 categorical S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a6 ?s2) (has_constraint a6 categorical S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S0 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S0 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S0 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S0 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S0) (assign (added_parameter_aut a6 categorical S0) (variable_value c1)))
	)

	(:action add_parameter_a10_S7_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a10 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a10 ?s2) (has_constraint a10 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S7 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S7 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S7 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S7 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S7) (assign (added_parameter_aut a10 integer S7) (variable_value v5)))
	)

	(:action add_parameter_a6_S0_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a6 categorical S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a6 ?s2) (has_constraint a6 categorical S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S0 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S0 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S0 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S0 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S0) (assign (added_parameter_aut a6 categorical S0) (variable_value c2)))
	)

	(:action add_parameter_a2_S7_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a2 categorical S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a2 ?s2) (has_constraint a2 categorical S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S7 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S7 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S7 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S7 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S7) (assign (added_parameter_aut a2 categorical S7) (variable_value c3)))
	)

	(:action add_parameter_a6_S0_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a6 categorical S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a6 ?s2) (has_constraint a6 categorical S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S0 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S0 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S0 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S0 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S0) (assign (added_parameter_aut a6 categorical S0) (variable_value c3)))
	)

	(:action add_parameter_a1_S8_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a1 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a1 ?s2) (has_constraint a1 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S8 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S8 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S8 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S8 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S8) (assign (added_parameter_aut a1 integer S8) (variable_value v0)))
	)

	(:action add_parameter_a1_S8_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a1 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a1 ?s2) (has_constraint a1 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S8 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S8 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S8 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S8 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S8) (assign (added_parameter_aut a1 integer S8) (variable_value v30)))
	)

	(:action add_parameter_a2_S7_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a2 categorical S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a2 ?s2) (has_constraint a2 categorical S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S7 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S7 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S7 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S7 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S7) (assign (added_parameter_aut a2 categorical S7) (variable_value c1)))
	)

	(:action add_parameter_a1_S8_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a1 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a1 ?s2) (has_constraint a1 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S8 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S8 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S8 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S8 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S8) (assign (added_parameter_aut a1 integer S8) (variable_value v15)))
	)

	(:action add_parameter_a1_S8_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a1 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a1 ?s2) (has_constraint a1 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S8 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S8 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S8 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S8 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S8) (assign (added_parameter_aut a1 integer S8) (variable_value v5)))
	)

	(:action add_parameter_a16_S13_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a16 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a16 ?s2) (has_constraint a16 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S13 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S13 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S13 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S13 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S13) (assign (added_parameter_aut a16 integer S13) (variable_value v5)))
	)

	(:action add_parameter_a16_S13_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a16 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a16 ?s2) (has_constraint a16 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S13 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S13 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S13 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S13 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S13) (assign (added_parameter_aut a16 integer S13) (variable_value v15)))
	)

	(:action add_parameter_a16_S13_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a16 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a16 ?s2) (has_constraint a16 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S13 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S13 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S13 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S13 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S13) (assign (added_parameter_aut a16 integer S13) (variable_value v0)))
	)

	(:action add_parameter_a16_S13_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a16 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a16 ?s2) (has_constraint a16 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S13 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S13 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S13 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S13 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S13) (assign (added_parameter_aut a16 integer S13) (variable_value v30)))
	)

	(:action add_parameter_a6_S16_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a6 categorical S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a6 ?s2) (has_constraint a6 categorical S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S16 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S16 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S16 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S16 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S16) (assign (added_parameter_aut a6 categorical S16) (variable_value c3)))
	)

	(:action add_parameter_a6_S16_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a6 categorical S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a6 ?s2) (has_constraint a6 categorical S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S16 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S16 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S16 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S16 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S16) (assign (added_parameter_aut a6 categorical S16) (variable_value c1)))
	)

	(:action add_action_a4_R2
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a4)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a4 R2) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a4 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a4 R2)) (after_add) (complete_sync a4))
	)

	(:action add_action_a4_R1
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a4)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a4 R1) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a4 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a4 R1)) (after_add) (complete_sync a4))
	)

	(:action add_parameter_a15_S18_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a15 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a15 ?s2) (has_constraint a15 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S18 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S18 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S18 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S18 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S18) (assign (added_parameter_aut a15 integer S18) (variable_value v30)))
	)

	(:action add_parameter_a19_S1_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a19 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a19 ?s2) (has_constraint a19 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S1 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S1 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S1 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S1 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S1) (assign (added_parameter_aut a19 integer S1) (variable_value v30)))
	)

	(:action add_parameter_a15_S18_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a15 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a15 ?s2) (has_constraint a15 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S18 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S18 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S18 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S18 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S18) (assign (added_parameter_aut a15 integer S18) (variable_value v0)))
	)

	(:action add_parameter_a19_S1_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a19 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a19 ?s2) (has_constraint a19 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S1 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S1 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S1 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S1 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S1) (assign (added_parameter_aut a19 integer S1) (variable_value v0)))
	)

	(:action add_parameter_a19_S1_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a19 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a19 ?s2) (has_constraint a19 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S1 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S1 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S1 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S1 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S1) (assign (added_parameter_aut a19 integer S1) (variable_value v15)))
	)

	(:action add_parameter_a19_S1_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a19 integer S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a19 ?s2) (has_constraint a19 integer S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S1 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S1 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S1 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S1 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S1) (assign (added_parameter_aut a19 integer S1) (variable_value v5)))
	)

	(:action add_parameter_a9_S1_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a9 categorical S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a9 ?s2) (has_constraint a9 categorical S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S1 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S1 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S1 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S1 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S1) (assign (added_parameter_aut a9 categorical S1) (variable_value c1)))
	)

	(:action add_parameter_a15_S18_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a15 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a15 ?s2) (has_constraint a15 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S18 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S18 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S18 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S18 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S18) (assign (added_parameter_aut a15 integer S18) (variable_value v5)))
	)

	(:action add_parameter_a9_S1_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S1) (not (goal_state S1)) (not (has_added_parameter_aut a9 categorical S1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S1 a9 ?s2) (has_constraint a9 categorical S1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S1 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S1 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S1 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S1 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S1) (assign (added_parameter_aut a9 categorical S1) (variable_value c2)))
	)

	(:action add_parameter_a15_S18_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a15 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a15 ?s2) (has_constraint a15 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S18 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S18 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S18 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S18 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S18) (assign (added_parameter_aut a15 integer S18) (variable_value v15)))
	)

	(:action add_parameter_a11_S5_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a11 categorical S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a11 ?s2) (has_constraint a11 categorical S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S5 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S5 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S5 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S5 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S5) (assign (added_parameter_aut a11 categorical S5) (variable_value c3)))
	)

	(:action add_parameter_a18_S8_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a18 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a18 ?s2) (has_constraint a18 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S8 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S8 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S8 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S8 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S8) (assign (added_parameter_aut a18 integer S8) (variable_value v5)))
	)

	(:action add_parameter_a3_S2_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a3 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a3 ?s2) (has_constraint a3 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S2 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S2 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S2 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S2 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S2) (assign (added_parameter_aut a3 integer S2) (variable_value v5)))
	)

	(:action add_parameter_a11_S5_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a11 categorical S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a11 ?s2) (has_constraint a11 categorical S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S5 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S5 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S5 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S5 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S5) (assign (added_parameter_aut a11 categorical S5) (variable_value c2)))
	)

	(:action add_parameter_a3_S2_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a3 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a3 ?s2) (has_constraint a3 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S2 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S2 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S2 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S2 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S2) (assign (added_parameter_aut a3 integer S2) (variable_value v15)))
	)

	(:action add_parameter_a12_S0_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a12 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a12 ?s2) (has_constraint a12 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S0 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S0 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S0 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S0 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S0) (assign (added_parameter_aut a12 integer S0) (variable_value v5)))
	)

	(:action add_parameter_a12_S0_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a12 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a12 ?s2) (has_constraint a12 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S0 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S0 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S0 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S0 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S0) (assign (added_parameter_aut a12 integer S0) (variable_value v0)))
	)

	(:action add_parameter_a12_S0_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a12 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a12 ?s2) (has_constraint a12 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S0 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S0 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S0 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S0 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S0) (assign (added_parameter_aut a12 integer S0) (variable_value v15)))
	)

	(:action add_action_a18_R2
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a18)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a18 R2) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a18 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a18 R2)) (after_add) (complete_sync a18))
	)

	(:action add_parameter_a12_S0_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a12 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a12 ?s2) (has_constraint a12 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S0 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S0 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S0 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S0 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S0) (assign (added_parameter_aut a12 integer S0) (variable_value v30)))
	)

	(:action add_parameter_a11_S5_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a11 categorical S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a11 ?s2) (has_constraint a11 categorical S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S5 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S5 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S5 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S5 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S5) (assign (added_parameter_aut a11 categorical S5) (variable_value c1)))
	)

	(:action add_action_a19_R0
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a19)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a19 R0) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a19 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a19 R0)) (after_add) (complete_sync a19))
	)

	(:action add_parameter_a3_S2_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a3 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a3 ?s2) (has_constraint a3 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S2 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S2 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S2 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S2 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S2) (assign (added_parameter_aut a3 integer S2) (variable_value v30)))
	)

	(:action add_parameter_a18_S8_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a18 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a18 ?s2) (has_constraint a18 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S8 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S8 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S8 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S8 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S8) (assign (added_parameter_aut a18 integer S8) (variable_value v30)))
	)

	(:action add_parameter_a3_S2_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S2) (not (goal_state S2)) (not (has_added_parameter_aut a3 integer S2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S2 a3 ?s2) (has_constraint a3 integer S2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S2 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S2 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S2 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S2 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S2) (assign (added_parameter_aut a3 integer S2) (variable_value v0)))
	)

	(:action add_parameter_a18_S8_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a18 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a18 ?s2) (has_constraint a18 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S8 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S8 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S8 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S8 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S8) (assign (added_parameter_aut a18 integer S8) (variable_value v0)))
	)

	(:action add_parameter_a18_S8_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a18 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a18 ?s2) (has_constraint a18 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S8 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S8 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S8 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S8 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S8) (assign (added_parameter_aut a18 integer S8) (variable_value v15)))
	)

	(:action add_parameter_a6_S13_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a6 categorical S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a6 ?s2) (has_constraint a6 categorical S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S13 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S13 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S13 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S13 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S13) (assign (added_parameter_aut a6 categorical S13) (variable_value c1)))
	)

	(:action add_parameter_a6_S13_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a6 categorical S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a6 ?s2) (has_constraint a6 categorical S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S13 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S13 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S13 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S13 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S13) (assign (added_parameter_aut a6 categorical S13) (variable_value c2)))
	)

	(:action add_parameter_a3_S18_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a3 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a3 ?s2) (has_constraint a3 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S18 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S18 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S18 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S18 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S18) (assign (added_parameter_aut a3 integer S18) (variable_value v0)))
	)

	(:action add_parameter_a3_S18_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a3 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a3 ?s2) (has_constraint a3 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S18 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S18 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S18 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S18 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S18) (assign (added_parameter_aut a3 integer S18) (variable_value v15)))
	)

	(:action add_parameter_a3_S18_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a3 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a3 ?s2) (has_constraint a3 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S18 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S18 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S18 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S18 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S18) (assign (added_parameter_aut a3 integer S18) (variable_value v30)))
	)

	(:action add_parameter_a15_sDEC1_1_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a15 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a15 ?s2) (has_constraint a15 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer sDEC1_1 ?s2)) (< (variable_value v5) (minority_constraint a15 integer sDEC1_1 ?s2)) (= (variable_value v5) (equality_constraint a15 integer sDEC1_1 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer sDEC1_1 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer sDEC1_1) (assign (added_parameter_aut a15 integer sDEC1_1) (variable_value v5)))
	)

	(:action add_parameter_a15_sDEC1_1_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a15 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a15 ?s2) (has_constraint a15 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer sDEC1_1 ?s2)) (< (variable_value v0) (minority_constraint a15 integer sDEC1_1 ?s2)) (= (variable_value v0) (equality_constraint a15 integer sDEC1_1 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer sDEC1_1 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer sDEC1_1) (assign (added_parameter_aut a15 integer sDEC1_1) (variable_value v0)))
	)

	(:action add_parameter_a15_sDEC1_1_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a15 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a15 ?s2) (has_constraint a15 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer sDEC1_1 ?s2)) (< (variable_value v15) (minority_constraint a15 integer sDEC1_1 ?s2)) (= (variable_value v15) (equality_constraint a15 integer sDEC1_1 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer sDEC1_1 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer sDEC1_1) (assign (added_parameter_aut a15 integer sDEC1_1) (variable_value v15)))
	)

	(:action add_action_a19_R2
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a19)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a19 R2) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a19 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a19 R2)) (after_add) (complete_sync a19))
	)

	(:action add_parameter_a15_sDEC1_1_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a15 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a15 ?s2) (has_constraint a15 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer sDEC1_1 ?s2)) (< (variable_value v30) (minority_constraint a15 integer sDEC1_1 ?s2)) (= (variable_value v30) (equality_constraint a15 integer sDEC1_1 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer sDEC1_1 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer sDEC1_1) (assign (added_parameter_aut a15 integer sDEC1_1) (variable_value v30)))
	)

	(:action add_action_a16_R2
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a16)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a16 R2) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a16 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a16 R2)) (after_add) (complete_sync a16))
	)

	(:action add_action_a16_R0
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a16)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a16 R0) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a16 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a16 R0)) (after_add) (complete_sync a16))
	)

	(:action add_action_a16_R1
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a16)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a16 R1) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a16 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a16 R1)) (after_add) (complete_sync a16))
	)

	(:action add_parameter_a10_S6_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a10 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a10 ?s2) (has_constraint a10 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S6 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S6 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S6 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S6 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S6) (assign (added_parameter_aut a10 integer S6) (variable_value v30)))
	)

	(:action add_parameter_a9_S11_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a9 categorical S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a9 ?s2) (has_constraint a9 categorical S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S11 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S11 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S11 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S11 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S11) (assign (added_parameter_aut a9 categorical S11) (variable_value c3)))
	)

	(:action add_parameter_a2_S6_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a2 categorical S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a2 ?s2) (has_constraint a2 categorical S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S6 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S6 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S6 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S6 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S6) (assign (added_parameter_aut a2 categorical S6) (variable_value c2)))
	)

	(:action add_parameter_a6_sDEC1_2_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a6 categorical sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a6 ?s2) (has_constraint a6 categorical sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical sDEC1_2 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical sDEC1_2 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical sDEC1_2 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical sDEC1_2 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical sDEC1_2) (assign (added_parameter_aut a6 categorical sDEC1_2) (variable_value c2)))
	)

	(:action add_parameter_a1_S5_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a1 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a1 ?s2) (has_constraint a1 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S5 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S5 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S5 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S5 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S5) (assign (added_parameter_aut a1 integer S5) (variable_value v5)))
	)

	(:action add_parameter_a2_S6_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a2 categorical S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a2 ?s2) (has_constraint a2 categorical S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S6 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S6 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S6 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S6 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S6) (assign (added_parameter_aut a2 categorical S6) (variable_value c1)))
	)

	(:action add_parameter_a10_S6_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a10 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a10 ?s2) (has_constraint a10 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S6 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S6 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S6 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S6 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S6) (assign (added_parameter_aut a10 integer S6) (variable_value v15)))
	)

	(:action add_action_a1_R0
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a1)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a1 R0) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a1 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a1 R0)) (after_add) (complete_sync a1))
	)

	(:action add_parameter_a10_S6_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a10 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a10 ?s2) (has_constraint a10 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S6 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S6 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S6 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S6 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S6) (assign (added_parameter_aut a10 integer S6) (variable_value v0)))
	)

	(:action add_parameter_a6_sDEC1_2_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a6 categorical sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a6 ?s2) (has_constraint a6 categorical sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical sDEC1_2 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical sDEC1_2 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical sDEC1_2 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical sDEC1_2 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical sDEC1_2) (assign (added_parameter_aut a6 categorical sDEC1_2) (variable_value c1)))
	)

	(:action add_parameter_a10_S6_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a10 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a10 ?s2) (has_constraint a10 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S6 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S6 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S6 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S6 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S6) (assign (added_parameter_aut a10 integer S6) (variable_value v5)))
	)

	(:action add_parameter_a6_sDEC1_2_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a6 categorical sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a6 ?s2) (has_constraint a6 categorical sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical sDEC1_2 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical sDEC1_2 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical sDEC1_2 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical sDEC1_2 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical sDEC1_2) (assign (added_parameter_aut a6 categorical sDEC1_2) (variable_value c3)))
	)

	(:action add_parameter_a1_S5_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a1 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a1 ?s2) (has_constraint a1 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S5 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S5 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S5 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S5 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S5) (assign (added_parameter_aut a1 integer S5) (variable_value v0)))
	)

	(:action add_parameter_a1_S5_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a1 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a1 ?s2) (has_constraint a1 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S5 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S5 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S5 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S5 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S5) (assign (added_parameter_aut a1 integer S5) (variable_value v30)))
	)

	(:action add_parameter_a2_S6_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a2 categorical S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a2 ?s2) (has_constraint a2 categorical S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S6 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S6 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S6 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S6 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S6) (assign (added_parameter_aut a2 categorical S6) (variable_value c3)))
	)

	(:action add_parameter_a1_S5_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a1 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a1 ?s2) (has_constraint a1 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S5 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S5 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S5 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S5 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S5) (assign (added_parameter_aut a1 integer S5) (variable_value v15)))
	)

	(:action add_parameter_a16_S10_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a16 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a16 ?s2) (has_constraint a16 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S10 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S10 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S10 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S10 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S10) (assign (added_parameter_aut a16 integer S10) (variable_value v5)))
	)

	(:action add_parameter_a12_S16_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a12 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a12 ?s2) (has_constraint a12 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S16 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S16 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S16 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S16 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S16) (assign (added_parameter_aut a12 integer S16) (variable_value v5)))
	)

	(:action add_parameter_a3_S18_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S18) (not (goal_state S18)) (not (has_added_parameter_aut a3 integer S18)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S18 a3 ?s2) (has_constraint a3 integer S18 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S18 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S18 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S18 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S18 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S18 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S18) (assign (added_parameter_aut a3 integer S18) (variable_value v5)))
	)

	(:action add_parameter_a16_S10_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a16 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a16 ?s2) (has_constraint a16 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S10 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S10 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S10 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S10 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S10) (assign (added_parameter_aut a16 integer S10) (variable_value v15)))
	)

	(:action add_parameter_a16_S10_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a16 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a16 ?s2) (has_constraint a16 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S10 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S10 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S10 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S10 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S10) (assign (added_parameter_aut a16 integer S10) (variable_value v0)))
	)

	(:action add_parameter_a12_S16_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a12 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a12 ?s2) (has_constraint a12 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S16 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S16 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S16 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S16 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S16) (assign (added_parameter_aut a12 integer S16) (variable_value v0)))
	)

	(:action add_parameter_a12_S16_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a12 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a12 ?s2) (has_constraint a12 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S16 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S16 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S16 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S16 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S16) (assign (added_parameter_aut a12 integer S16) (variable_value v30)))
	)

	(:action add_parameter_a16_S10_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a16 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a16 ?s2) (has_constraint a16 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S10 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S10 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S10 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S10 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S10) (assign (added_parameter_aut a16 integer S10) (variable_value v30)))
	)

	(:action add_parameter_a12_S16_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a12 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a12 ?s2) (has_constraint a12 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S16 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S16 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S16 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S16 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S16) (assign (added_parameter_aut a12 integer S16) (variable_value v15)))
	)

	(:action add_parameter_a6_S12_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a6 categorical S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a6 ?s2) (has_constraint a6 categorical S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S12 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S12 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S12 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S12 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S12) (assign (added_parameter_aut a6 categorical S12) (variable_value c3)))
	)

	(:action add_action_a0_R0
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a0)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a0 R0) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a0 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a0 R0)) (after_add) (complete_sync a0))
	)

	(:action add_parameter_a19_S11_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a19 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a19 ?s2) (has_constraint a19 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S11 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S11 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S11 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S11 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S11) (assign (added_parameter_aut a19 integer S11) (variable_value v30)))
	)

	(:action add_parameter_a19_S11_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a19 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a19 ?s2) (has_constraint a19 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S11 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S11 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S11 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S11 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S11) (assign (added_parameter_aut a19 integer S11) (variable_value v0)))
	)

	(:action add_parameter_a19_S11_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a19 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a19 ?s2) (has_constraint a19 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S11 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S11 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S11 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S11 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S11) (assign (added_parameter_aut a19 integer S11) (variable_value v15)))
	)

	(:action add_parameter_a19_S11_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a19 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a19 ?s2) (has_constraint a19 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S11 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S11 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S11 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S11 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S11) (assign (added_parameter_aut a19 integer S11) (variable_value v5)))
	)

	(:action add_parameter_a9_S11_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a9 categorical S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a9 ?s2) (has_constraint a9 categorical S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S11 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S11 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S11 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S11 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S11) (assign (added_parameter_aut a9 categorical S11) (variable_value c2)))
	)

	(:action add_parameter_a15_S14_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a15 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a15 ?s2) (has_constraint a15 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S14 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S14 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S14 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S14 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S14) (assign (added_parameter_aut a15 integer S14) (variable_value v5)))
	)

	(:action add_parameter_a15_S14_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a15 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a15 ?s2) (has_constraint a15 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S14 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S14 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S14 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S14 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S14) (assign (added_parameter_aut a15 integer S14) (variable_value v15)))
	)

	(:action skip-unused_t1_a0_t2
		:parameters ()
		:precondition (and (cur_t_state t1) (trace t1 a0 t2) (not (recovery_finished)) (not (exists (?s1 - automaton_state ?s2 - automaton_state) (and (automaton ?s1 a0 ?s2) (not (failure_state ?s2)) ) )) )
		:effect (and (not (cur_t_state t1)) (cur_t_state t2) (when (final_t_state t2) (recovery_finished)))
	)

	(:action add_parameter_a9_S11_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a9 categorical S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a9 ?s2) (has_constraint a9 categorical S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S11 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S11 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S11 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S11 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S11) (assign (added_parameter_aut a9 categorical S11) (variable_value c1)))
	)

	(:action add_parameter_a15_S14_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a15 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a15 ?s2) (has_constraint a15 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S14 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S14 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S14 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S14 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S14) (assign (added_parameter_aut a15 integer S14) (variable_value v30)))
	)

	(:action add_parameter_a15_S14_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a15 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a15 ?s2) (has_constraint a15 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S14 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S14 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S14 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S14 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S14) (assign (added_parameter_aut a15 integer S14) (variable_value v0)))
	)

	(:action add_parameter_a16_S0_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a16 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a16 ?s2) (has_constraint a16 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S0 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S0 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S0 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S0 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S0) (assign (added_parameter_aut a16 integer S0) (variable_value v5)))
	)

	(:action add_parameter_a11_S10_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a11 categorical S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a11 ?s2) (has_constraint a11 categorical S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S10 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S10 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S10 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S10 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S10) (assign (added_parameter_aut a11 categorical S10) (variable_value c1)))
	)

	(:action add_parameter_a12_S7_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a12 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a12 ?s2) (has_constraint a12 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S7 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S7 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S7 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S7 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S7) (assign (added_parameter_aut a12 integer S7) (variable_value v5)))
	)

	(:action add_parameter_a12_S7_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a12 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a12 ?s2) (has_constraint a12 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S7 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S7 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S7 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S7 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S7) (assign (added_parameter_aut a12 integer S7) (variable_value v0)))
	)

	(:action add_parameter_a12_S7_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a12 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a12 ?s2) (has_constraint a12 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S7 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S7 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S7 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S7 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S7) (assign (added_parameter_aut a12 integer S7) (variable_value v15)))
	)

	(:action add_parameter_a11_S10_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a11 categorical S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a11 ?s2) (has_constraint a11 categorical S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S10 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S10 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S10 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S10 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S10) (assign (added_parameter_aut a11 categorical S10) (variable_value c2)))
	)

	(:action add_parameter_a11_S10_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a11 categorical S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a11 ?s2) (has_constraint a11 categorical S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S10 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S10 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S10 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S10 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S10) (assign (added_parameter_aut a11 categorical S10) (variable_value c3)))
	)

	(:action add_parameter_a12_S7_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S7) (not (goal_state S7)) (not (has_added_parameter_aut a12 integer S7)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S7 a12 ?s2) (has_constraint a12 integer S7 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S7 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S7 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S7 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S7 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S7 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S7) (assign (added_parameter_aut a12 integer S7) (variable_value v30)))
	)

	(:action add_parameter_a16_S0_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a16 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a16 ?s2) (has_constraint a16 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S0 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S0 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S0 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S0 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S0) (assign (added_parameter_aut a16 integer S0) (variable_value v30)))
	)

	(:action add_parameter_a16_S0_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a16 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a16 ?s2) (has_constraint a16 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S0 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S0 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S0 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S0 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S0) (assign (added_parameter_aut a16 integer S0) (variable_value v0)))
	)

	(:action add_parameter_a16_S0_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S0) (not (goal_state S0)) (not (has_added_parameter_aut a16 integer S0)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S0 a16 ?s2) (has_constraint a16 integer S0 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S0 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S0 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S0 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S0 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S0 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S0) (assign (added_parameter_aut a16 integer S0) (variable_value v15)))
	)

	(:action add_parameter_a3_S8_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a3 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a3 ?s2) (has_constraint a3 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S8 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S8 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S8 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S8 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S8) (assign (added_parameter_aut a3 integer S8) (variable_value v15)))
	)

	(:action add_parameter_a18_S13_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a18 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a18 ?s2) (has_constraint a18 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S13 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S13 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S13 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S13 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S13) (assign (added_parameter_aut a18 integer S13) (variable_value v15)))
	)

	(:action add_parameter_a3_S8_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a3 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a3 ?s2) (has_constraint a3 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S8 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S8 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S8 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S8 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S8) (assign (added_parameter_aut a3 integer S8) (variable_value v30)))
	)

	(:action add_parameter_a18_S13_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a18 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a18 ?s2) (has_constraint a18 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S13 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S13 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S13 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S13 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S13) (assign (added_parameter_aut a18 integer S13) (variable_value v5)))
	)

	(:action add_action_a15_R2
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a15)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a15 R2) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a15 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a15 R2)) (after_add) (complete_sync a15))
	)

	(:action add_parameter_a3_S8_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a3 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a3 ?s2) (has_constraint a3 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S8 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S8 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S8 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S8 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S8) (assign (added_parameter_aut a3 integer S8) (variable_value v0)))
	)

	(:action add_parameter_a3_S8_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S8) (not (goal_state S8)) (not (has_added_parameter_aut a3 integer S8)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S8 a3 ?s2) (has_constraint a3 integer S8 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S8 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S8 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S8 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S8 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S8 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S8) (assign (added_parameter_aut a3 integer S8) (variable_value v5)))
	)

	(:action add_parameter_a18_S13_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a18 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a18 ?s2) (has_constraint a18 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S13 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S13 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S13 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S13 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S13) (assign (added_parameter_aut a18 integer S13) (variable_value v30)))
	)

	(:action add_parameter_a18_S13_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S13) (not (goal_state S13)) (not (has_added_parameter_aut a18 integer S13)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S13 a18 ?s2) (has_constraint a18 integer S13 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S13 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S13 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S13 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S13 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S13 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S13) (assign (added_parameter_aut a18 integer S13) (variable_value v0)))
	)

	(:action add_parameter_a15_S5_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a15 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a15 ?s2) (has_constraint a15 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S5 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S5 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S5 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S5 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S5) (assign (added_parameter_aut a15 integer S5) (variable_value v5)))
	)

	(:action add_parameter_a19_sDEC1_1_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a19 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a19 ?s2) (has_constraint a19 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer sDEC1_1 ?s2)) (< (variable_value v5) (minority_constraint a19 integer sDEC1_1 ?s2)) (= (variable_value v5) (equality_constraint a19 integer sDEC1_1 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer sDEC1_1 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer sDEC1_1) (assign (added_parameter_aut a19 integer sDEC1_1) (variable_value v5)))
	)

	(:action add_parameter_a15_S5_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a15 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a15 ?s2) (has_constraint a15 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S5 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S5 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S5 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S5 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S5) (assign (added_parameter_aut a15 integer S5) (variable_value v0)))
	)

	(:action add_parameter_a15_S5_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a15 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a15 ?s2) (has_constraint a15 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S5 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S5 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S5 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S5 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S5) (assign (added_parameter_aut a15 integer S5) (variable_value v15)))
	)

	(:action add_parameter_a15_S5_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a15 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a15 ?s2) (has_constraint a15 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S5 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S5 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S5 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S5 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S5) (assign (added_parameter_aut a15 integer S5) (variable_value v30)))
	)

	(:action add_parameter_a19_sDEC1_1_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a19 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a19 ?s2) (has_constraint a19 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer sDEC1_1 ?s2)) (< (variable_value v30) (minority_constraint a19 integer sDEC1_1 ?s2)) (= (variable_value v30) (equality_constraint a19 integer sDEC1_1 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer sDEC1_1 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer sDEC1_1) (assign (added_parameter_aut a19 integer sDEC1_1) (variable_value v30)))
	)

	(:action add_parameter_a9_sDEC1_1_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a9 categorical sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a9 ?s2) (has_constraint a9 categorical sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical sDEC1_1 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical sDEC1_1 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical sDEC1_1 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical sDEC1_1 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical sDEC1_1) (assign (added_parameter_aut a9 categorical sDEC1_1) (variable_value c2)))
	)

	(:action add_parameter_a19_sDEC1_1_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a19 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a19 ?s2) (has_constraint a19 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer sDEC1_1 ?s2)) (< (variable_value v0) (minority_constraint a19 integer sDEC1_1 ?s2)) (= (variable_value v0) (equality_constraint a19 integer sDEC1_1 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer sDEC1_1 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer sDEC1_1) (assign (added_parameter_aut a19 integer sDEC1_1) (variable_value v0)))
	)

	(:action add_parameter_a19_sDEC1_1_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a19 integer sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a19 ?s2) (has_constraint a19 integer sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer sDEC1_1 ?s2)) (< (variable_value v15) (minority_constraint a19 integer sDEC1_1 ?s2)) (= (variable_value v15) (equality_constraint a19 integer sDEC1_1 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer sDEC1_1 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer sDEC1_1) (assign (added_parameter_aut a19 integer sDEC1_1) (variable_value v15)))
	)

	(:action add_parameter_a9_sDEC1_1_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a9 categorical sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a9 ?s2) (has_constraint a9 categorical sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical sDEC1_1 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical sDEC1_1 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical sDEC1_1 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical sDEC1_1 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical sDEC1_1) (assign (added_parameter_aut a9 categorical sDEC1_1) (variable_value c1)))
	)

	(:action add_action_a12_R0
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a12)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a12 R0) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a12 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a12 R0)) (after_add) (complete_sync a12))
	)

	(:action add_action_a12_R1
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a12)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a12 R1) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a12 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a12 R1)) (after_add) (complete_sync a12))
	)

	(:action add_parameter_a9_sDEC1_1_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state sDEC1_1) (not (goal_state sDEC1_1)) (not (has_added_parameter_aut a9 categorical sDEC1_1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_1 a9 ?s2) (has_constraint a9 categorical sDEC1_1 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical sDEC1_1 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical sDEC1_1 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical sDEC1_1 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical sDEC1_1 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical sDEC1_1 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical sDEC1_1) (assign (added_parameter_aut a9 categorical sDEC1_1) (variable_value c3)))
	)

	(:action add_parameter_a9_S14_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a9 categorical S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a9 ?s2) (has_constraint a9 categorical S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S14 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S14 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S14 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S14 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S14) (assign (added_parameter_aut a9 categorical S14) (variable_value c1)))
	)

	(:action add_parameter_a10_S11_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a10 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a10 ?s2) (has_constraint a10 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S11 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S11 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S11 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S11 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S11) (assign (added_parameter_aut a10 integer S11) (variable_value v5)))
	)

	(:action add_parameter_a18_sDEC1_2_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a18 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a18 ?s2) (has_constraint a18 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer sDEC1_2 ?s2)) (< (variable_value v5) (minority_constraint a18 integer sDEC1_2 ?s2)) (= (variable_value v5) (equality_constraint a18 integer sDEC1_2 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer sDEC1_2 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer sDEC1_2) (assign (added_parameter_aut a18 integer sDEC1_2) (variable_value v5)))
	)

	(:action add_parameter_a9_S14_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a9 categorical S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a9 ?s2) (has_constraint a9 categorical S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S14 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S14 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S14 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S14 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S14) (assign (added_parameter_aut a9 categorical S14) (variable_value c2)))
	)

	(:action add_parameter_a10_S11_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a10 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a10 ?s2) (has_constraint a10 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S11 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S11 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S11 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S11 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S11) (assign (added_parameter_aut a10 integer S11) (variable_value v30)))
	)

	(:action add_parameter_a9_S14_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a9 categorical S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a9 ?s2) (has_constraint a9 categorical S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S14 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S14 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S14 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S14 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S14) (assign (added_parameter_aut a9 categorical S14) (variable_value c3)))
	)

	(:action add_parameter_a10_S11_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a10 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a10 ?s2) (has_constraint a10 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S11 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S11 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S11 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S11 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S11) (assign (added_parameter_aut a10 integer S11) (variable_value v15)))
	)

	(:action add_parameter_a10_S11_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a10 integer S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a10 ?s2) (has_constraint a10 integer S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S11 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S11 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S11 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S11 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S11) (assign (added_parameter_aut a10 integer S11) (variable_value v0)))
	)

	(:action add_parameter_a18_sDEC1_2_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a18 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a18 ?s2) (has_constraint a18 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer sDEC1_2 ?s2)) (< (variable_value v30) (minority_constraint a18 integer sDEC1_2 ?s2)) (= (variable_value v30) (equality_constraint a18 integer sDEC1_2 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer sDEC1_2 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer sDEC1_2) (assign (added_parameter_aut a18 integer sDEC1_2) (variable_value v30)))
	)

	(:action add_parameter_a18_sDEC1_2_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a18 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a18 ?s2) (has_constraint a18 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer sDEC1_2 ?s2)) (< (variable_value v0) (minority_constraint a18 integer sDEC1_2 ?s2)) (= (variable_value v0) (equality_constraint a18 integer sDEC1_2 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer sDEC1_2 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer sDEC1_2) (assign (added_parameter_aut a18 integer sDEC1_2) (variable_value v0)))
	)

	(:action add_parameter_a18_sDEC1_2_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a18 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a18 ?s2) (has_constraint a18 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer sDEC1_2 ?s2)) (< (variable_value v15) (minority_constraint a18 integer sDEC1_2 ?s2)) (= (variable_value v15) (equality_constraint a18 integer sDEC1_2 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer sDEC1_2 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer sDEC1_2) (assign (added_parameter_aut a18 integer sDEC1_2) (variable_value v15)))
	)

	(:action add_parameter_a2_S11_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a2 categorical S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a2 ?s2) (has_constraint a2 categorical S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S11 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S11 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S11 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S11 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S11) (assign (added_parameter_aut a2 categorical S11) (variable_value c1)))
	)

	(:action add_parameter_a6_S6_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a6 categorical S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a6 ?s2) (has_constraint a6 categorical S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S6 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S6 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S6 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S6 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S6) (assign (added_parameter_aut a6 categorical S6) (variable_value c1)))
	)

	(:action add_parameter_a1_S10_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a1 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a1 ?s2) (has_constraint a1 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S10 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S10 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S10 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S10 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S10) (assign (added_parameter_aut a1 integer S10) (variable_value v15)))
	)

	(:action add_parameter_a16_S16_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a16 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a16 ?s2) (has_constraint a16 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S16 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S16 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S16 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S16 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S16) (assign (added_parameter_aut a16 integer S16) (variable_value v15)))
	)

	(:action add_parameter_a6_S6_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a6 categorical S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a6 ?s2) (has_constraint a6 categorical S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S6 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S6 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S6 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S6 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S6) (assign (added_parameter_aut a6 categorical S6) (variable_value c2)))
	)

	(:action add_parameter_a16_S16_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a16 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a16 ?s2) (has_constraint a16 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S16 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S16 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S16 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S16 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S16) (assign (added_parameter_aut a16 integer S16) (variable_value v0)))
	)

	(:action add_action_a17_R1
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a17)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a17 R1) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a17 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a17 R1)) (after_add) (complete_sync a17))
	)

	(:action add_parameter_a1_S10_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a1 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a1 ?s2) (has_constraint a1 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S10 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S10 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S10 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S10 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S10) (assign (added_parameter_aut a1 integer S10) (variable_value v5)))
	)

	(:action add_parameter_a16_S16_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a16 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a16 ?s2) (has_constraint a16 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S16 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S16 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S16 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S16 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S16) (assign (added_parameter_aut a16 integer S16) (variable_value v30)))
	)

	(:action add_parameter_a6_S6_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a6 categorical S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a6 ?s2) (has_constraint a6 categorical S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S6 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S6 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S6 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S6 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S6) (assign (added_parameter_aut a6 categorical S6) (variable_value c3)))
	)

	(:action add_parameter_a2_S11_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a2 categorical S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a2 ?s2) (has_constraint a2 categorical S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S11 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S11 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S11 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S11 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S11) (assign (added_parameter_aut a2 categorical S11) (variable_value c2)))
	)

	(:action add_parameter_a2_S11_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S11) (not (goal_state S11)) (not (has_added_parameter_aut a2 categorical S11)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S11 a2 ?s2) (has_constraint a2 categorical S11 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S11 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S11 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S11 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S11 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S11 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S11) (assign (added_parameter_aut a2 categorical S11) (variable_value c3)))
	)

	(:action add_parameter_a1_S10_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a1 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a1 ?s2) (has_constraint a1 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S10 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S10 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S10 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S10 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S10) (assign (added_parameter_aut a1 integer S10) (variable_value v0)))
	)

	(:action add_parameter_a1_S10_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a1 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a1 ?s2) (has_constraint a1 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S10 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S10 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S10 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S10 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S10) (assign (added_parameter_aut a1 integer S10) (variable_value v30)))
	)

	(:action add_parameter_a16_S16_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a16 integer S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a16 ?s2) (has_constraint a16 integer S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S16 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S16 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S16 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S16 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S16) (assign (added_parameter_aut a16 integer S16) (variable_value v5)))
	)

	(:action skip-unused_t2_a1_t3
		:parameters ()
		:precondition (and (cur_t_state t2) (trace t2 a1 t3) (not (recovery_finished)) (not (exists (?s1 - automaton_state ?s2 - automaton_state) (and (automaton ?s1 a1 ?s2) (not (failure_state ?s2)) ) )) )
		:effect (and (not (cur_t_state t2)) (cur_t_state t3) (when (final_t_state t3) (recovery_finished)))
	)

	(:action add_parameter_a19_S14_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a19 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a19 ?s2) (has_constraint a19 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S14 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S14 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S14 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S14 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S14) (assign (added_parameter_aut a19 integer S14) (variable_value v5)))
	)

	(:action add_action_a14_R2
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a14)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a14 R2) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a14 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a14 R2)) (after_add) (complete_sync a14))
	)

	(:action add_parameter_a19_S14_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a19 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a19 ?s2) (has_constraint a19 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S14 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S14 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S14 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S14 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S14) (assign (added_parameter_aut a19 integer S14) (variable_value v30)))
	)

	(:action add_parameter_a19_S14_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a19 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a19 ?s2) (has_constraint a19 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S14 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S14 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S14 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S14 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S14) (assign (added_parameter_aut a19 integer S14) (variable_value v0)))
	)

	(:action add_parameter_a19_S14_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S14) (not (goal_state S14)) (not (has_added_parameter_aut a19 integer S14)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S14 a19 ?s2) (has_constraint a19 integer S14 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S14 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S14 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S14 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S14 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S14 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S14) (assign (added_parameter_aut a19 integer S14) (variable_value v15)))
	)

	(:action add_parameter_a16_sDEC1_2_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a16 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a16 ?s2) (has_constraint a16 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer sDEC1_2 ?s2)) (< (variable_value v0) (minority_constraint a16 integer sDEC1_2 ?s2)) (= (variable_value v0) (equality_constraint a16 integer sDEC1_2 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer sDEC1_2 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer sDEC1_2) (assign (added_parameter_aut a16 integer sDEC1_2) (variable_value v0)))
	)

	(:action add_parameter_a12_S6_integer_v0
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v0 a12 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a12 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a12 ?s2) (has_constraint a12 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a12 integer S6 ?s2)) (< (variable_value v0) (minority_constraint a12 integer S6 ?s2)) (= (variable_value v0) (equality_constraint a12 integer S6 ?s2)) (> (variable_value v0) (inequality_constraint a12 integer S6 ?s2)) (< (variable_value v0) (inequality_constraint a12 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S6) (assign (added_parameter_aut a12 integer S6) (variable_value v0)))
	)

	(:action add_parameter_a12_S6_integer_v15
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v15 a12 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a12 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a12 ?s2) (has_constraint a12 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a12 integer S6 ?s2)) (< (variable_value v15) (minority_constraint a12 integer S6 ?s2)) (= (variable_value v15) (equality_constraint a12 integer S6 ?s2)) (> (variable_value v15) (inequality_constraint a12 integer S6 ?s2)) (< (variable_value v15) (inequality_constraint a12 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S6) (assign (added_parameter_aut a12 integer S6) (variable_value v15)))
	)

	(:action add_parameter_a16_sDEC1_2_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a16 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a16 ?s2) (has_constraint a16 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer sDEC1_2 ?s2)) (< (variable_value v15) (minority_constraint a16 integer sDEC1_2 ?s2)) (= (variable_value v15) (equality_constraint a16 integer sDEC1_2 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer sDEC1_2 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer sDEC1_2) (assign (added_parameter_aut a16 integer sDEC1_2) (variable_value v15)))
	)

	(:action add_parameter_a16_sDEC1_2_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a16 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a16 ?s2) (has_constraint a16 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer sDEC1_2 ?s2)) (< (variable_value v5) (minority_constraint a16 integer sDEC1_2 ?s2)) (= (variable_value v5) (equality_constraint a16 integer sDEC1_2 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer sDEC1_2 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer sDEC1_2) (assign (added_parameter_aut a16 integer sDEC1_2) (variable_value v5)))
	)

	(:action add_parameter_a12_S6_integer_v30
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v30 a12 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a12 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a12 ?s2) (has_constraint a12 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a12 integer S6 ?s2)) (< (variable_value v30) (minority_constraint a12 integer S6 ?s2)) (= (variable_value v30) (equality_constraint a12 integer S6 ?s2)) (> (variable_value v30) (inequality_constraint a12 integer S6 ?s2)) (< (variable_value v30) (inequality_constraint a12 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S6) (assign (added_parameter_aut a12 integer S6) (variable_value v30)))
	)

	(:action add_parameter_a11_S9_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c1 a11 categorical) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a11 categorical S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a11 ?s2) (has_constraint a11 categorical S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a11 categorical S9 ?s2)) (< (variable_value c1) (minority_constraint a11 categorical S9 ?s2)) (= (variable_value c1) (equality_constraint a11 categorical S9 ?s2)) (> (variable_value c1) (inequality_constraint a11 categorical S9 ?s2)) (< (variable_value c1) (inequality_constraint a11 categorical S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S9) (assign (added_parameter_aut a11 categorical S9) (variable_value c1)))
	)

	(:action add_parameter_a11_S9_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c3 a11 categorical) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a11 categorical S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a11 ?s2) (has_constraint a11 categorical S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a11 categorical S9 ?s2)) (< (variable_value c3) (minority_constraint a11 categorical S9 ?s2)) (= (variable_value c3) (equality_constraint a11 categorical S9 ?s2)) (> (variable_value c3) (inequality_constraint a11 categorical S9 ?s2)) (< (variable_value c3) (inequality_constraint a11 categorical S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S9) (assign (added_parameter_aut a11 categorical S9) (variable_value c3)))
	)

	(:action reset_Response_ActivityG_ActivityP
		:parameters ()
		:precondition (and (violated Response_ActivityG_ActivityP) (not (after_sync)) (not (after_add)) (not (after_add_check)))
		:effect (and (increase (total_cost) (violation_cost Response_ActivityG_ActivityP)) (forall (?s1 ?s2 - automaton_state) (when (and (cur_s_state ?s1) (not (goal_state ?s1))  (initial_state ?s2) (associated ?s1 Response_ActivityG_ActivityP) (associated ?s2 Response_ActivityG_ActivityP) (not (failure_state ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (not (failure)) (not (violated Response_ActivityG_ActivityP)) )
	)

	(:action add_parameter_a11_S9_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a11) (after_add) (has_substitution_value c2 a11 categorical) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a11 categorical S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a11 ?s2) (has_constraint a11 categorical S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a11 categorical S9 ?s2)) (< (variable_value c2) (minority_constraint a11 categorical S9 ?s2)) (= (variable_value c2) (equality_constraint a11 categorical S9 ?s2)) (> (variable_value c2) (inequality_constraint a11 categorical S9 ?s2)) (< (variable_value c2) (inequality_constraint a11 categorical S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a11 categorical S9) (assign (added_parameter_aut a11 categorical S9) (variable_value c2)))
	)

	(:action reset_pn
		:parameters ()
		:precondition (and (violated pn) (not (after_sync)) (not (after_add)) (not (after_add_check)))
		:effect (and (increase (total_cost) (violation_cost pn)) (forall (?s1 ?s2 - automaton_state) (when (and (cur_s_state ?s1) (not (goal_state ?s1))  (initial_state ?s2) (associated ?s1 pn) (associated ?s2 pn) (not (failure_state ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) ) ) ) (not (failure)) (not (violated pn)) )
	)

	(:action add_parameter_a16_sDEC1_2_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state sDEC1_2) (not (goal_state sDEC1_2)) (not (has_added_parameter_aut a16 integer sDEC1_2)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton sDEC1_2 a16 ?s2) (has_constraint a16 integer sDEC1_2 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer sDEC1_2 ?s2)) (< (variable_value v30) (minority_constraint a16 integer sDEC1_2 ?s2)) (= (variable_value v30) (equality_constraint a16 integer sDEC1_2 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer sDEC1_2 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer sDEC1_2 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer sDEC1_2) (assign (added_parameter_aut a16 integer sDEC1_2) (variable_value v30)))
	)

	(:action add_parameter_a12_S6_integer_v5
		:parameters ()
		:precondition (and (complete_sync a12) (after_add) (has_substitution_value v5 a12 integer) (cur_s_state S6) (not (goal_state S6)) (not (has_added_parameter_aut a12 integer S6)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S6 a12 ?s2) (has_constraint a12 integer S6 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a12 integer S6 ?s2)) (< (variable_value v5) (minority_constraint a12 integer S6 ?s2)) (= (variable_value v5) (equality_constraint a12 integer S6 ?s2)) (> (variable_value v5) (inequality_constraint a12 integer S6 ?s2)) (< (variable_value v5) (inequality_constraint a12 integer S6 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a12 integer S6) (assign (added_parameter_aut a12 integer S6) (variable_value v5)))
	)

	(:action add_parameter_a3_S5_integer_v30
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v30 a3 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a3 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a3 ?s2) (has_constraint a3 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a3 integer S5 ?s2)) (< (variable_value v30) (minority_constraint a3 integer S5 ?s2)) (= (variable_value v30) (equality_constraint a3 integer S5 ?s2)) (> (variable_value v30) (inequality_constraint a3 integer S5 ?s2)) (< (variable_value v30) (inequality_constraint a3 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S5) (assign (added_parameter_aut a3 integer S5) (variable_value v30)))
	)

	(:action add_parameter_a18_S10_integer_v30
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v30 a18 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a18 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a18 ?s2) (has_constraint a18 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a18 integer S10 ?s2)) (< (variable_value v30) (minority_constraint a18 integer S10 ?s2)) (= (variable_value v30) (equality_constraint a18 integer S10 ?s2)) (> (variable_value v30) (inequality_constraint a18 integer S10 ?s2)) (< (variable_value v30) (inequality_constraint a18 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S10) (assign (added_parameter_aut a18 integer S10) (variable_value v30)))
	)

	(:action add_parameter_a3_S5_integer_v0
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v0 a3 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a3 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a3 ?s2) (has_constraint a3 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a3 integer S5 ?s2)) (< (variable_value v0) (minority_constraint a3 integer S5 ?s2)) (= (variable_value v0) (equality_constraint a3 integer S5 ?s2)) (> (variable_value v0) (inequality_constraint a3 integer S5 ?s2)) (< (variable_value v0) (inequality_constraint a3 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S5) (assign (added_parameter_aut a3 integer S5) (variable_value v0)))
	)

	(:action add_parameter_a18_S10_integer_v0
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v0 a18 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a18 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a18 ?s2) (has_constraint a18 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a18 integer S10 ?s2)) (< (variable_value v0) (minority_constraint a18 integer S10 ?s2)) (= (variable_value v0) (equality_constraint a18 integer S10 ?s2)) (> (variable_value v0) (inequality_constraint a18 integer S10 ?s2)) (< (variable_value v0) (inequality_constraint a18 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S10) (assign (added_parameter_aut a18 integer S10) (variable_value v0)))
	)

	(:action add_parameter_a18_S10_integer_v15
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v15 a18 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a18 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a18 ?s2) (has_constraint a18 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a18 integer S10 ?s2)) (< (variable_value v15) (minority_constraint a18 integer S10 ?s2)) (= (variable_value v15) (equality_constraint a18 integer S10 ?s2)) (> (variable_value v15) (inequality_constraint a18 integer S10 ?s2)) (< (variable_value v15) (inequality_constraint a18 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S10) (assign (added_parameter_aut a18 integer S10) (variable_value v15)))
	)

	(:action add_parameter_a18_S10_integer_v5
		:parameters ()
		:precondition (and (complete_sync a18) (after_add) (has_substitution_value v5 a18 integer) (cur_s_state S10) (not (goal_state S10)) (not (has_added_parameter_aut a18 integer S10)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S10 a18 ?s2) (has_constraint a18 integer S10 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a18 integer S10 ?s2)) (< (variable_value v5) (minority_constraint a18 integer S10 ?s2)) (= (variable_value v5) (equality_constraint a18 integer S10 ?s2)) (> (variable_value v5) (inequality_constraint a18 integer S10 ?s2)) (< (variable_value v5) (inequality_constraint a18 integer S10 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a18 integer S10) (assign (added_parameter_aut a18 integer S10) (variable_value v5)))
	)

	(:action add_parameter_a3_S5_integer_v5
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v5 a3 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a3 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a3 ?s2) (has_constraint a3 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a3 integer S5 ?s2)) (< (variable_value v5) (minority_constraint a3 integer S5 ?s2)) (= (variable_value v5) (equality_constraint a3 integer S5 ?s2)) (> (variable_value v5) (inequality_constraint a3 integer S5 ?s2)) (< (variable_value v5) (inequality_constraint a3 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S5) (assign (added_parameter_aut a3 integer S5) (variable_value v5)))
	)

	(:action add_parameter_a3_S5_integer_v15
		:parameters ()
		:precondition (and (complete_sync a3) (after_add) (has_substitution_value v15 a3 integer) (cur_s_state S5) (not (goal_state S5)) (not (has_added_parameter_aut a3 integer S5)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S5 a3 ?s2) (has_constraint a3 integer S5 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a3 integer S5 ?s2)) (< (variable_value v15) (minority_constraint a3 integer S5 ?s2)) (= (variable_value v15) (equality_constraint a3 integer S5 ?s2)) (> (variable_value v15) (inequality_constraint a3 integer S5 ?s2)) (< (variable_value v15) (inequality_constraint a3 integer S5 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a3 integer S5) (assign (added_parameter_aut a3 integer S5) (variable_value v15)))
	)

	(:action add_action_a11_R0
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a11)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a11 R0) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a11 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a11 R0)) (after_add) (complete_sync a11))
	)

	(:action add_parameter_a6_S16_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S16) (not (goal_state S16)) (not (has_added_parameter_aut a6 categorical S16)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S16 a6 ?s2) (has_constraint a6 categorical S16 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S16 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S16 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S16 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S16 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S16 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S16) (assign (added_parameter_aut a6 categorical S16) (variable_value c2)))
	)

	(:action validate-payload_t0_a5_t1
		:parameters ()
		:precondition (and (cur_t_state t0) (trace t0 a5 t1) (not (after_sync)) (not (after_add)) (not (failure)) (not (complete_sync a5)) (not (after_add_check)) (not (exists (?c - constraint) (violated ?c) )) (not (recovery_finished)) (exists (?s1 - automaton_state ?s2 - automaton_state ) (and (cur_s_state ?s1) (not (failure_state ?s1)) (not (goal_state ?s1)) (automaton ?s1 a5 ?s2) (not (invalid ?s1 a5 ?s2)) ) ))
		:effect (and (increase (total_cost) 0) (after_sync) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 a5 ?s2) (has_constraint a5 ?pn ?s1 ?s2) (or (not (has_parameter a5 ?pn t0 t1)) (< (trace_parameter a5 ?pn t0 t1) (majority_constraint a5 ?pn ?s1 ?s2)) (> (trace_parameter a5 ?pn t0 t1) (minority_constraint a5 ?pn ?s1 ?s2)) (< (trace_parameter a5 ?pn t0 t1) (interval_constraint_lower a5 ?pn ?s1 ?s2)) (> (trace_parameter a5 ?pn t0 t1) (interval_constraint_higher a5 ?pn ?s1 ?s2)) (< (trace_parameter a5 ?pn t0 t1) (equality_constraint a5 ?pn ?s1 ?s2)) (> (trace_parameter a5 ?pn t0 t1) (equality_constraint a5 ?pn ?s1 ?s2)) (= (trace_parameter a5 ?pn t0 t1) (inequality_constraint a5 ?pn ?s1 ?s2)) ) ) (invalid ?s1 a5 ?s2) ) ) )
	)

	(:action add_parameter_a15_S4_integer_v0
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v0 a15 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a15 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a15 ?s2) (has_constraint a15 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a15 integer S4 ?s2)) (< (variable_value v0) (minority_constraint a15 integer S4 ?s2)) (= (variable_value v0) (equality_constraint a15 integer S4 ?s2)) (> (variable_value v0) (inequality_constraint a15 integer S4 ?s2)) (< (variable_value v0) (inequality_constraint a15 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S4) (assign (added_parameter_aut a15 integer S4) (variable_value v0)))
	)

	(:action add_parameter_a15_S4_integer_v15
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v15 a15 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a15 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a15 ?s2) (has_constraint a15 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a15 integer S4 ?s2)) (< (variable_value v15) (minority_constraint a15 integer S4 ?s2)) (= (variable_value v15) (equality_constraint a15 integer S4 ?s2)) (> (variable_value v15) (inequality_constraint a15 integer S4 ?s2)) (< (variable_value v15) (inequality_constraint a15 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S4) (assign (added_parameter_aut a15 integer S4) (variable_value v15)))
	)

	(:action add_parameter_a15_S4_integer_v30
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v30 a15 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a15 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a15 ?s2) (has_constraint a15 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a15 integer S4 ?s2)) (< (variable_value v30) (minority_constraint a15 integer S4 ?s2)) (= (variable_value v30) (equality_constraint a15 integer S4 ?s2)) (> (variable_value v30) (inequality_constraint a15 integer S4 ?s2)) (< (variable_value v30) (inequality_constraint a15 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S4) (assign (added_parameter_aut a15 integer S4) (variable_value v30)))
	)

	(:action add_parameter_a15_S4_integer_v5
		:parameters ()
		:precondition (and (complete_sync a15) (after_add) (has_substitution_value v5 a15 integer) (cur_s_state S4) (not (goal_state S4)) (not (has_added_parameter_aut a15 integer S4)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S4 a15 ?s2) (has_constraint a15 integer S4 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a15 integer S4 ?s2)) (< (variable_value v5) (minority_constraint a15 integer S4 ?s2)) (= (variable_value v5) (equality_constraint a15 integer S4 ?s2)) (> (variable_value v5) (inequality_constraint a15 integer S4 ?s2)) (< (variable_value v5) (inequality_constraint a15 integer S4 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a15 integer S4) (assign (added_parameter_aut a15 integer S4) (variable_value v5)))
	)

	(:action add_parameter_a10_S17_integer_v15
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v15 a10 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a10 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a10 ?s2) (has_constraint a10 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a10 integer S17 ?s2)) (< (variable_value v15) (minority_constraint a10 integer S17 ?s2)) (= (variable_value v15) (equality_constraint a10 integer S17 ?s2)) (> (variable_value v15) (inequality_constraint a10 integer S17 ?s2)) (< (variable_value v15) (inequality_constraint a10 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S17) (assign (added_parameter_aut a10 integer S17) (variable_value v15)))
	)

	(:action add_parameter_a10_S17_integer_v0
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v0 a10 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a10 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a10 ?s2) (has_constraint a10 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a10 integer S17 ?s2)) (< (variable_value v0) (minority_constraint a10 integer S17 ?s2)) (= (variable_value v0) (equality_constraint a10 integer S17 ?s2)) (> (variable_value v0) (inequality_constraint a10 integer S17 ?s2)) (< (variable_value v0) (inequality_constraint a10 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S17) (assign (added_parameter_aut a10 integer S17) (variable_value v0)))
	)

	(:action add_parameter_a9_S15_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c1 a9 categorical) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a9 categorical S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a9 ?s2) (has_constraint a9 categorical S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a9 categorical S15 ?s2)) (< (variable_value c1) (minority_constraint a9 categorical S15 ?s2)) (= (variable_value c1) (equality_constraint a9 categorical S15 ?s2)) (> (variable_value c1) (inequality_constraint a9 categorical S15 ?s2)) (< (variable_value c1) (inequality_constraint a9 categorical S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S15) (assign (added_parameter_aut a9 categorical S15) (variable_value c1)))
	)

	(:action add_parameter_a10_S17_integer_v5
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v5 a10 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a10 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a10 ?s2) (has_constraint a10 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a10 integer S17 ?s2)) (< (variable_value v5) (minority_constraint a10 integer S17 ?s2)) (= (variable_value v5) (equality_constraint a10 integer S17 ?s2)) (> (variable_value v5) (inequality_constraint a10 integer S17 ?s2)) (< (variable_value v5) (inequality_constraint a10 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S17) (assign (added_parameter_aut a10 integer S17) (variable_value v5)))
	)

	(:action sync-actions_t0_t1_a5
		:parameters ()
		:precondition (and (not (after_add)) (not (failure)) (not (after_add_check)) (not (complete_sync a5)) (after_sync) (cur_t_state t0) (trace t0 a5 t1) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (automaton ?s1 a5 ?s2) ) ) )
		:effect (and (increase (total_cost) 0) (not (cur_t_state t0)) (cur_t_state t1) (when (final_t_state t1) (recovery_finished)) (not (after_sync)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (not (invalid ?s1 a5 ?s2)) (automaton ?s1 a5 ?s2) (cur_s_state ?s1) (not (failure_state ?s2)) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) )) ) (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint) (when (and (not (invalid ?s1 a5 ?s2)) (automaton ?s1 a5 ?s2) (cur_s_state ?s1) (failure_state ?s2) (associated ?s1 ?c) (associated ?s2 ?c) ) (and (not (cur_s_state ?s1)) (cur_s_state ?s2) (failure) (violated ?c) )) ) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (invalid ?s1 a5 ?s2) (automaton ?s1 a5 ?s2) ) (not (invalid ?s1 a5 ?s2)) ) ) )
	)

	(:action add_parameter_a10_S17_integer_v30
		:parameters ()
		:precondition (and (complete_sync a10) (after_add) (has_substitution_value v30 a10 integer) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a10 integer S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a10 ?s2) (has_constraint a10 integer S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a10 integer S17 ?s2)) (< (variable_value v30) (minority_constraint a10 integer S17 ?s2)) (= (variable_value v30) (equality_constraint a10 integer S17 ?s2)) (> (variable_value v30) (inequality_constraint a10 integer S17 ?s2)) (< (variable_value v30) (inequality_constraint a10 integer S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a10 integer S17) (assign (added_parameter_aut a10 integer S17) (variable_value v30)))
	)

	(:action add_parameter_a9_S15_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c3 a9 categorical) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a9 categorical S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a9 ?s2) (has_constraint a9 categorical S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a9 categorical S15 ?s2)) (< (variable_value c3) (minority_constraint a9 categorical S15 ?s2)) (= (variable_value c3) (equality_constraint a9 categorical S15 ?s2)) (> (variable_value c3) (inequality_constraint a9 categorical S15 ?s2)) (< (variable_value c3) (inequality_constraint a9 categorical S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S15) (assign (added_parameter_aut a9 categorical S15) (variable_value c3)))
	)

	(:action add_parameter_a6_S3_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c2 a6 categorical) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a6 categorical S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a6 ?s2) (has_constraint a6 categorical S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a6 categorical S3 ?s2)) (< (variable_value c2) (minority_constraint a6 categorical S3 ?s2)) (= (variable_value c2) (equality_constraint a6 categorical S3 ?s2)) (> (variable_value c2) (inequality_constraint a6 categorical S3 ?s2)) (< (variable_value c2) (inequality_constraint a6 categorical S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S3) (assign (added_parameter_aut a6 categorical S3) (variable_value c2)))
	)

	(:action add_parameter_a1_S9_integer_v0
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v0 a1 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a1 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a1 ?s2) (has_constraint a1 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a1 integer S9 ?s2)) (< (variable_value v0) (minority_constraint a1 integer S9 ?s2)) (= (variable_value v0) (equality_constraint a1 integer S9 ?s2)) (> (variable_value v0) (inequality_constraint a1 integer S9 ?s2)) (< (variable_value v0) (inequality_constraint a1 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S9) (assign (added_parameter_aut a1 integer S9) (variable_value v0)))
	)

	(:action add_parameter_a16_S12_integer_v0
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v0 a16 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a16 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a16 ?s2) (has_constraint a16 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a16 integer S12 ?s2)) (< (variable_value v0) (minority_constraint a16 integer S12 ?s2)) (= (variable_value v0) (equality_constraint a16 integer S12 ?s2)) (> (variable_value v0) (inequality_constraint a16 integer S12 ?s2)) (< (variable_value v0) (inequality_constraint a16 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S12) (assign (added_parameter_aut a16 integer S12) (variable_value v0)))
	)

	(:action add_parameter_a1_S9_integer_v30
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v30 a1 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a1 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a1 ?s2) (has_constraint a1 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a1 integer S9 ?s2)) (< (variable_value v30) (minority_constraint a1 integer S9 ?s2)) (= (variable_value v30) (equality_constraint a1 integer S9 ?s2)) (> (variable_value v30) (inequality_constraint a1 integer S9 ?s2)) (< (variable_value v30) (inequality_constraint a1 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S9) (assign (added_parameter_aut a1 integer S9) (variable_value v30)))
	)

	(:action add_parameter_a16_S12_integer_v30
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v30 a16 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a16 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a16 ?s2) (has_constraint a16 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a16 integer S12 ?s2)) (< (variable_value v30) (minority_constraint a16 integer S12 ?s2)) (= (variable_value v30) (equality_constraint a16 integer S12 ?s2)) (> (variable_value v30) (inequality_constraint a16 integer S12 ?s2)) (< (variable_value v30) (inequality_constraint a16 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S12) (assign (added_parameter_aut a16 integer S12) (variable_value v30)))
	)

	(:action add_parameter_a6_S3_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c1 a6 categorical) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a6 categorical S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a6 ?s2) (has_constraint a6 categorical S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a6 categorical S3 ?s2)) (< (variable_value c1) (minority_constraint a6 categorical S3 ?s2)) (= (variable_value c1) (equality_constraint a6 categorical S3 ?s2)) (> (variable_value c1) (inequality_constraint a6 categorical S3 ?s2)) (< (variable_value c1) (inequality_constraint a6 categorical S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S3) (assign (added_parameter_aut a6 categorical S3) (variable_value c1)))
	)

	(:action add_parameter_a2_S17_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c3 a2 categorical) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a2 categorical S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a2 ?s2) (has_constraint a2 categorical S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a2 categorical S17 ?s2)) (< (variable_value c3) (minority_constraint a2 categorical S17 ?s2)) (= (variable_value c3) (equality_constraint a2 categorical S17 ?s2)) (> (variable_value c3) (inequality_constraint a2 categorical S17 ?s2)) (< (variable_value c3) (inequality_constraint a2 categorical S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S17) (assign (added_parameter_aut a2 categorical S17) (variable_value c3)))
	)

	(:action add_parameter_a1_S9_integer_v15
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v15 a1 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a1 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a1 ?s2) (has_constraint a1 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a1 integer S9 ?s2)) (< (variable_value v15) (minority_constraint a1 integer S9 ?s2)) (= (variable_value v15) (equality_constraint a1 integer S9 ?s2)) (> (variable_value v15) (inequality_constraint a1 integer S9 ?s2)) (< (variable_value v15) (inequality_constraint a1 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S9) (assign (added_parameter_aut a1 integer S9) (variable_value v15)))
	)

	(:action add_parameter_a2_S17_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c2 a2 categorical) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a2 categorical S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a2 ?s2) (has_constraint a2 categorical S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a2 categorical S17 ?s2)) (< (variable_value c2) (minority_constraint a2 categorical S17 ?s2)) (= (variable_value c2) (equality_constraint a2 categorical S17 ?s2)) (> (variable_value c2) (inequality_constraint a2 categorical S17 ?s2)) (< (variable_value c2) (inequality_constraint a2 categorical S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S17) (assign (added_parameter_aut a2 categorical S17) (variable_value c2)))
	)

	(:action add_action_a13_R2
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a13)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a13 R2) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a13 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a13 R2)) (after_add) (complete_sync a13))
	)

	(:action add_parameter_a1_S9_integer_v5
		:parameters ()
		:precondition (and (complete_sync a1) (after_add) (has_substitution_value v5 a1 integer) (cur_s_state S9) (not (goal_state S9)) (not (has_added_parameter_aut a1 integer S9)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S9 a1 ?s2) (has_constraint a1 integer S9 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a1 integer S9 ?s2)) (< (variable_value v5) (minority_constraint a1 integer S9 ?s2)) (= (variable_value v5) (equality_constraint a1 integer S9 ?s2)) (> (variable_value v5) (inequality_constraint a1 integer S9 ?s2)) (< (variable_value v5) (inequality_constraint a1 integer S9 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a1 integer S9) (assign (added_parameter_aut a1 integer S9) (variable_value v5)))
	)

	(:action add_action_a13_R0
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a13)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a13 R0) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a13 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a13 R0)) (after_add) (complete_sync a13))
	)

	(:action add_parameter_a2_S17_categorical_c1
		:parameters ()
		:precondition (and (complete_sync a2) (after_add) (has_substitution_value c1 a2 categorical) (cur_s_state S17) (not (goal_state S17)) (not (has_added_parameter_aut a2 categorical S17)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S17 a2 ?s2) (has_constraint a2 categorical S17 ?s2) (not (failure_state ?s2)) (or (> (variable_value c1) (majority_constraint a2 categorical S17 ?s2)) (< (variable_value c1) (minority_constraint a2 categorical S17 ?s2)) (= (variable_value c1) (equality_constraint a2 categorical S17 ?s2)) (> (variable_value c1) (inequality_constraint a2 categorical S17 ?s2)) (< (variable_value c1) (inequality_constraint a2 categorical S17 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a2 categorical S17) (assign (added_parameter_aut a2 categorical S17) (variable_value c1)))
	)

	(:action add_parameter_a6_S3_categorical_c3
		:parameters ()
		:precondition (and (complete_sync a6) (after_add) (has_substitution_value c3 a6 categorical) (cur_s_state S3) (not (goal_state S3)) (not (has_added_parameter_aut a6 categorical S3)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S3 a6 ?s2) (has_constraint a6 categorical S3 ?s2) (not (failure_state ?s2)) (or (> (variable_value c3) (majority_constraint a6 categorical S3 ?s2)) (< (variable_value c3) (minority_constraint a6 categorical S3 ?s2)) (= (variable_value c3) (equality_constraint a6 categorical S3 ?s2)) (> (variable_value c3) (inequality_constraint a6 categorical S3 ?s2)) (< (variable_value c3) (inequality_constraint a6 categorical S3 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a6 categorical S3) (assign (added_parameter_aut a6 categorical S3) (variable_value c3)))
	)

	(:action add_action_a13_R1
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a13)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a13 R1) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a13 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a13 R1)) (after_add) (complete_sync a13))
	)

	(:action add_parameter_a16_S12_integer_v5
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v5 a16 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a16 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a16 ?s2) (has_constraint a16 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a16 integer S12 ?s2)) (< (variable_value v5) (minority_constraint a16 integer S12 ?s2)) (= (variable_value v5) (equality_constraint a16 integer S12 ?s2)) (> (variable_value v5) (inequality_constraint a16 integer S12 ?s2)) (< (variable_value v5) (inequality_constraint a16 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S12) (assign (added_parameter_aut a16 integer S12) (variable_value v5)))
	)

	(:action add_parameter_a16_S12_integer_v15
		:parameters ()
		:precondition (and (complete_sync a16) (after_add) (has_substitution_value v15 a16 integer) (cur_s_state S12) (not (goal_state S12)) (not (has_added_parameter_aut a16 integer S12)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S12 a16 ?s2) (has_constraint a16 integer S12 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a16 integer S12 ?s2)) (< (variable_value v15) (minority_constraint a16 integer S12 ?s2)) (= (variable_value v15) (equality_constraint a16 integer S12 ?s2)) (> (variable_value v15) (inequality_constraint a16 integer S12 ?s2)) (< (variable_value v15) (inequality_constraint a16 integer S12 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a16 integer S12) (assign (added_parameter_aut a16 integer S12) (variable_value v15)))
	)

	(:action add_parameter_a19_S15_integer_v15
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v15 a19 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a19 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a19 ?s2) (has_constraint a19 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v15) (majority_constraint a19 integer S15 ?s2)) (< (variable_value v15) (minority_constraint a19 integer S15 ?s2)) (= (variable_value v15) (equality_constraint a19 integer S15 ?s2)) (> (variable_value v15) (inequality_constraint a19 integer S15 ?s2)) (< (variable_value v15) (inequality_constraint a19 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S15) (assign (added_parameter_aut a19 integer S15) (variable_value v15)))
	)

	(:action add_parameter_a19_S15_integer_v5
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v5 a19 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a19 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a19 ?s2) (has_constraint a19 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v5) (majority_constraint a19 integer S15 ?s2)) (< (variable_value v5) (minority_constraint a19 integer S15 ?s2)) (= (variable_value v5) (equality_constraint a19 integer S15 ?s2)) (> (variable_value v5) (inequality_constraint a19 integer S15 ?s2)) (< (variable_value v5) (inequality_constraint a19 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S15) (assign (added_parameter_aut a19 integer S15) (variable_value v5)))
	)

	(:action add_action_a10_R2
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a10)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a10 R2) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a10 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a10 R2)) (after_add) (complete_sync a10))
	)

	(:action add_action_a10_R0
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a10)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a10 R0) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a10 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a10 R0)) (after_add) (complete_sync a10))
	)

	(:action add_action_a10_R1
		:parameters ()
		:precondition (and (not (after_add)) (not (complete_sync a10)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work a10 R1) (not (exists (?c - constraint) (violated ?c) )) (exists (?s1 - automaton_state ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 a10 ?s2) (not (failure_state ?s2)) ) ) )
		:effect (and (increase (total_cost) (activity_cost a10 R1)) (after_add) (complete_sync a10))
	)

	(:action add_parameter_a9_S15_categorical_c2
		:parameters ()
		:precondition (and (complete_sync a9) (after_add) (has_substitution_value c2 a9 categorical) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a9 categorical S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a9 ?s2) (has_constraint a9 categorical S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value c2) (majority_constraint a9 categorical S15 ?s2)) (< (variable_value c2) (minority_constraint a9 categorical S15 ?s2)) (= (variable_value c2) (equality_constraint a9 categorical S15 ?s2)) (> (variable_value c2) (inequality_constraint a9 categorical S15 ?s2)) (< (variable_value c2) (inequality_constraint a9 categorical S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a9 categorical S15) (assign (added_parameter_aut a9 categorical S15) (variable_value c2)))
	)

	(:action add_parameter_a19_S15_integer_v30
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v30 a19 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a19 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a19 ?s2) (has_constraint a19 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v30) (majority_constraint a19 integer S15 ?s2)) (< (variable_value v30) (minority_constraint a19 integer S15 ?s2)) (= (variable_value v30) (equality_constraint a19 integer S15 ?s2)) (> (variable_value v30) (inequality_constraint a19 integer S15 ?s2)) (< (variable_value v30) (inequality_constraint a19 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S15) (assign (added_parameter_aut a19 integer S15) (variable_value v30)))
	)

	(:action add_parameter_a19_S15_integer_v0
		:parameters ()
		:precondition (and (complete_sync a19) (after_add) (has_substitution_value v0 a19 integer) (cur_s_state S15) (not (goal_state S15)) (not (has_added_parameter_aut a19 integer S15)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton S15 a19 ?s2) (has_constraint a19 integer S15 ?s2) (not (failure_state ?s2)) (or (> (variable_value v0) (majority_constraint a19 integer S15 ?s2)) (< (variable_value v0) (minority_constraint a19 integer S15 ?s2)) (= (variable_value v0) (equality_constraint a19 integer S15 ?s2)) (> (variable_value v0) (inequality_constraint a19 integer S15 ?s2)) (< (variable_value v0) (inequality_constraint a19 integer S15 ?s2)) ) ) ) )
		:effect (and (increase (total_cost) 0) (has_added_parameter_aut a19 integer S15) (assign (added_parameter_aut a19 integer S15) (variable_value v0)))
	)

)