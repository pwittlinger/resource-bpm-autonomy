(define (domain partially_grounded_domain)
(:requirements :strips :typing :equality :adl :fluents :action-costs)

  (:types activity automaton_state trace_state parameter_name value_name constraint resource)
    (:constants
    t1 t2 t0 t3 - trace_state
    S18 S16 S14 S12 S15 S13 S1 S10 S11 S9 S17 S8 S7 S5 S6 S4 S3 S2 S0 sDEC1_1 sDEC1_2 sDEC2_1 sDEC2_2 sDEC3_1 sDEC3_2 sDEC4_1 sDEC4_2 sDEC4_3 sDEC4_4 sDEC5_1 sDEC5_2 sDEC5_3 sDEC6_1 sDEC6_2 sDEC6_3 sDEC7_1 sDEC7_2 - automaton_state
    a11 a10 a13 a12 a15 a14 a17 a16 a19 a18 a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 - activity
    categorical integer - parameter_name
    c3 v30 v0 v15 c1 v5 c2 - value_name
    Absence_ActivityK Existence_ActivityB Response_ActivityG_ActivityP Precedence_ActivityO_ActivityF Not_Response_ActivityI_ActivityJ Chain_Response_ActivityA_ActivityC Response_ActivityN_ActivityT pn - constraint
    R2 R0 R1 - resource
  )


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
  
	(:action add_parameter_a3_sDEC3_2_integer_v0
        :parameters ()
        :precondition (and 
            (complete_sync a3) (after_add) (not (after_add_check)) 
            (cur_s_state sDEC3_2) (not (has_added_parameter_aut a3 integer sDEC3_2))
        )
        :effect (and 
            (has_added_parameter_aut a3 integer sDEC3_2) 
            (assign (added_parameter_aut a3 integer sDEC3_2) 0.0)
        )
	)

	(:action add_parameter_a3_sDEC3_2_integer_v5
        :parameters ()
        :precondition (and 
            (complete_sync a3) (after_add) (not (after_add_check)) 
            (cur_s_state sDEC3_2) (not (has_added_parameter_aut a3 integer sDEC3_2))
        )
        :effect (and 
            (has_added_parameter_aut a3 integer sDEC3_2) 
            (assign (added_parameter_aut a3 integer sDEC3_2) 5.0)
        )
	)

	(:action add_parameter_a10_sDEC6_1_integer_v0
        :parameters ()
        :precondition (and 
            (complete_sync a10) (after_add) (not (after_add_check)) 
            (cur_s_state sDEC6_1) (not (has_added_parameter_aut a10 integer sDEC6_1))
        )
        :effect (and 
            (has_added_parameter_aut a10 integer sDEC6_1) 
            (assign (added_parameter_aut a10 integer sDEC6_1) 0.0)
        )
	)

	(:action add_parameter_a15_sDEC7_1_integer_v15
        :parameters ()
        :precondition (and 
            (complete_sync a15) (after_add) (not (after_add_check)) 
            (cur_s_state sDEC7_1) (not (has_added_parameter_aut a15 integer sDEC7_1))
        )
        :effect (and 
            (has_added_parameter_aut a15 integer sDEC7_1) 
            (assign (added_parameter_aut a15 integer sDEC7_1) 15.0)
        )
	)

	(:action add_parameter_a15_sDEC7_1_integer_v30
        :parameters ()
        :precondition (and 
            (complete_sync a15) (after_add) (not (after_add_check)) 
            (cur_s_state sDEC7_1) (not (has_added_parameter_aut a15 integer sDEC7_1))
        )
        :effect (and 
            (has_added_parameter_aut a15 integer sDEC7_1) 
            (assign (added_parameter_aut a15 integer sDEC7_1) 30.0)
        )
	)

	(:action add_parameter_a16_sDEC3_1_integer_v15
        :parameters ()
        :precondition (and 
            (complete_sync a16) (after_add) (not (after_add_check)) 
            (cur_s_state sDEC3_1) (not (has_added_parameter_aut a16 integer sDEC3_1))
        )
        :effect (and 
            (has_added_parameter_aut a16 integer sDEC3_1) 
            (assign (added_parameter_aut a16 integer sDEC3_1) 15.0)
        )
	)

	(:action add_parameter_a16_sDEC3_1_integer_v30
        :parameters ()
        :precondition (and 
            (complete_sync a16) (after_add) (not (after_add_check)) 
            (cur_s_state sDEC3_1) (not (has_added_parameter_aut a16 integer sDEC3_1))
        )
        :effect (and 
            (has_added_parameter_aut a16 integer sDEC3_1) 
            (assign (added_parameter_aut a16 integer sDEC3_1) 30.0)
        )
	)

	(:action add_action_a7_R2
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a7)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S12) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a7 R2)) 
            (after_add) (complete_sync a7)
        )
	)

	(:action add_action_a7_R0
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a7)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S12) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a7 R0)) 
            (after_add) (complete_sync a7)
        )
	)

	(:action add_action_a7_R1
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a7)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S12) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a7 R1)) 
            (after_add) (complete_sync a7)
        )
	)

	(:action add_action_a6_R2
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a6)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (or (cur_s_state S14) (cur_s_state sDEC6_2)) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a6 R2)) 
            (after_add) (complete_sync a6)
        )
	)

	(:action add_action_a6_R0
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a6)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (or (cur_s_state S14) (cur_s_state sDEC6_2)) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a6 R0)) 
            (after_add) (complete_sync a6)
        )
	)

	(:action add_action_a6_R1
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a6)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (or (cur_s_state S14) (cur_s_state sDEC6_2)) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a6 R1)) 
            (after_add) (complete_sync a6)
        )
	)

	(:action add_action_a5_R1
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a5)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S4) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a5 R1)) 
            (after_add) (complete_sync a5)
        )
	)

	(:action add_action_a9_R2
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a9)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S10) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a9 R2)) 
            (after_add) (complete_sync a9)
        )
	)

	(:action add_action_a9_R0
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a9)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S10) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a9 R0)) 
            (after_add) (complete_sync a9)
        )
	)

	(:action add_action_a8_R0
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a8)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S13) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a8 R0)) 
            (after_add) (complete_sync a8)
        )
	)

	(:action add_action_a2_R2
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a2)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S7) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a2 R2)) 
            (after_add) (complete_sync a2)
        )
	)

	(:action add_parameter_a1_sDEC7_2_integer_v30
        :parameters ()
        :precondition (and 
            (complete_sync a1) (after_add) (not (after_add_check)) 
            (cur_s_state sDEC7_2) (not (has_added_parameter_aut a1 integer sDEC7_2))
        )
        :effect (and 
            (has_added_parameter_aut a1 integer sDEC7_2) 
            (assign (added_parameter_aut a1 integer sDEC7_2) 30.0)
        )
	)

	(:action add_action_a1_R0
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a1)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (or (cur_s_state S2) (cur_s_state sDEC7_2)) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a1 R0)) 
            (after_add) (complete_sync a1)
        )
	)

	(:action add_action_a1_R1
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a1)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (or (cur_s_state S2) (cur_s_state sDEC7_2)) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a1 R1)) 
            (after_add) (complete_sync a1)
        )
	)

	(:action add_parameter_a1_sDEC7_2_integer_v15
        :parameters ()
        :precondition (and 
            (complete_sync a1) (after_add) (not (after_add_check)) 
            (cur_s_state sDEC7_2) (not (has_added_parameter_aut a1 integer sDEC7_2))
        )
        :effect (and 
            (has_added_parameter_aut a1 integer sDEC7_2) 
            (assign (added_parameter_aut a1 integer sDEC7_2) 15.0)
        )
	)

	(:action add_action_a5_R2
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a5)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S4) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a5 R2)) 
            (after_add) (complete_sync a5)
        )
	)

	(:action add_action_a5_R0
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a5)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S4) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a5 R0)) 
            (after_add) (complete_sync a5)
        )
	)

	(:action add_action_a4_R1
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a4)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S6) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a4 R1)) 
            (after_add) (complete_sync a4)
        )
	)

	(:action add_action_a4_R2
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a4)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S6) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a4 R2)) 
            (after_add) (complete_sync a4)
        )
	)

	(:action add_action_a3_R0
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a3)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (or (cur_s_state S7) (cur_s_state sDEC3_2)) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a3 R0)) 
            (after_add) (complete_sync a3)
        )
	)

	(:action add_action_a3_R1
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a3)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (or (cur_s_state S7) (cur_s_state sDEC3_2)) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a3 R1)) 
            (after_add) (complete_sync a3)
        )
	)

	(:action add_parameter_a11_sDEC2_1_categorical_c2
        :parameters ()
        :precondition (and 
            (complete_sync a11) (after_add) (not (after_add_check)) 
            (cur_s_state sDEC2_1) (not (has_added_parameter_aut a11 categorical sDEC2_1))
        )
        :effect (and 
            (has_added_parameter_aut a11 categorical sDEC2_1) 
            (assign (added_parameter_aut a11 categorical sDEC2_1) 2.0)
        )
	)

	(:action add_action_a19_R2
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a19)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S1) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a19 R2)) 
            (after_add) (complete_sync a19)
        )
	)

	(:action add_action_a19_R0
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a19)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S1) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a19 R0)) 
            (after_add) (complete_sync a19)
        )
	)

	(:action add_action_a16_R2
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a16)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S14) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a16 R2)) 
            (after_add) (complete_sync a16)
        )
	)

	(:action add_action_a16_R0
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a16)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S14) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a16 R0)) 
            (after_add) (complete_sync a16)
        )
	)

	(:action add_action_a16_R1
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a16)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S14) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a16 R1)) 
            (after_add) (complete_sync a16)
        )
	)

	(:action add_action_a0_R0
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a0)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S3) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a0 R0)) 
            (after_add) (complete_sync a0)
        )
	)

	(:action add_action_a18_R2
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a18)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S15) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a18 R2)) 
            (after_add) (complete_sync a18)
        )
	)

	(:action add_action_a15_R2
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a15)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S5) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a15 R2)) 
            (after_add) (complete_sync a15)
        )
	)

	(:action add_action_a12_R0
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a12)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S11) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a12 R0)) 
            (after_add) (complete_sync a12)
        )
	)

	(:action add_action_a12_R1
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a12)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S11) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a12 R1)) 
            (after_add) (complete_sync a12)
        )
	)

	(:action add_action_a17_R1
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a17)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S11) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a17 R1)) 
            (after_add) (complete_sync a17)
        )
	)

	(:action add_action_a14_R2
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a14)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S8) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a14 R2)) 
            (after_add) (complete_sync a14)
        )
	)

	(:action add_action_a11_R0
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a11)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (or (cur_s_state S9) (cur_s_state sDEC2_1)) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a11 R0)) 
            (after_add) (complete_sync a11)
        )
	)

	(:action add_action_a13_R2
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a13)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S17) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a13 R2)) 
            (after_add) (complete_sync a13)
        )
	)

	(:action add_action_a13_R0
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a13)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S17) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a13 R0)) 
            (after_add) (complete_sync a13)
        )
	)

	(:action add_action_a13_R1
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a13)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S17) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a13 R1)) 
            (after_add) (complete_sync a13)
        )
	)

	(:action add_action_a10_R2
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a10)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S18) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a10 R2)) 
            (after_add) (complete_sync a10)
        )
	)

	(:action add_action_a10_R0
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a10)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S18) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a10 R0)) 
            (after_add) (complete_sync a10)
        )
	)

	(:action add_action_a10_R1
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync a10)) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            (cur_s_state S18) (and (not (violated Absence_ActivityK)) (not (violated Existence_ActivityB)) (not (violated Response_ActivityG_ActivityP)) (not (violated Precedence_ActivityO_ActivityF)) (not (violated Not_Response_ActivityI_ActivityJ)) (not (violated Chain_Response_ActivityA_ActivityC)) (not (violated Response_ActivityN_ActivityT)) (not (violated pn)))
        )
        :effect (and 
            (increase (total_cost) (activity_cost a10 R1)) 
            (after_add) (complete_sync a10)
        )
	)

	(:action add_parameter_a9_sDEC4_1_categorical_c2
        :parameters ()
        :precondition (and 
            (complete_sync a9) (after_add) (not (after_add_check)) 
            (cur_s_state sDEC4_1) (not (has_added_parameter_aut a9 categorical sDEC4_1))
        )
        :effect (and 
            (has_added_parameter_aut a9 categorical sDEC4_1) 
            (assign (added_parameter_aut a9 categorical sDEC4_1) 2.0)
        )
	)

	(:action add_parameter_a2_sDEC4_3_categorical_c1
        :parameters ()
        :precondition (and 
            (complete_sync a2) (after_add) (not (after_add_check)) 
            (cur_s_state sDEC4_3) (not (has_added_parameter_aut a2 categorical sDEC4_3))
        )
        :effect (and 
            (has_added_parameter_aut a2 categorical sDEC4_3) 
            (assign (added_parameter_aut a2 categorical sDEC4_3) 1.0)
        )
	)

	(:action add_parameter_a6_sDEC6_2_categorical_c1
        :parameters ()
        :precondition (and 
            (complete_sync a6) (after_add) (not (after_add_check)) 
            (cur_s_state sDEC6_2) (not (has_added_parameter_aut a6 categorical sDEC6_2))
        )
        :effect (and 
            (has_added_parameter_aut a6 categorical sDEC6_2) 
            (assign (added_parameter_aut a6 categorical sDEC6_2) 1.0)
        )
	)

(:action check_added_parameter_model
    :parameters (?a - activity)
    :precondition (and 
        (complete_sync ?a)
        (after_add)
        (not (after_add_check))
      )
    :effect (and 
        (after_add_check)
        (not (after_add))

      (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state)
          ;  ; If parameter is missing
            (when (and 
            
              ; validate that the current selection of states is a valid arc that reads the current parameter
              (cur_s_state ?s1)
              (automaton ?s1 ?a ?s2)
              (has_constraint ?a ?pn ?s1 ?s2)
              ;; 
              (or
                ;; If the arc has a guard but the added activity no additional payload -> defaults to invalid
                (not (has_added_parameter_aut ?a ?pn ?s1))
                ;; Or it has a constraint and the guard is NOT FULFILLED
                ;; I.e. Guard [X<10] but the new value X = 5 (added_parameter_aut)
                (and 
                  (has_added_parameter_aut ?a ?pn ?s1)
                  (or 
                    (< (added_parameter_aut ?a ?pn ?s1) (majority_constraint ?a ?pn ?s1 ?s2))
                    (> (added_parameter_aut ?a ?pn ?s1) (minority_constraint ?a ?pn ?s1 ?s2))
                    (< (added_parameter_aut ?a ?pn ?s1) (interval_constraint_lower ?a ?pn ?s1 ?s2))
                    (> (added_parameter_aut ?a ?pn ?s1) (interval_constraint_higher ?a ?pn ?s1 ?s2))
                    (< (added_parameter_aut ?a ?pn ?s1) (equality_constraint ?a ?pn ?s1 ?s2))
                    (> (added_parameter_aut ?a ?pn ?s1) (equality_constraint ?a ?pn ?s1 ?s2))
                    (= (added_parameter_aut ?a ?pn ?s1) (inequality_constraint ?a ?pn ?s1 ?s2))
                  )
                )
              )
              )

            (invalid ?s1 ?a ?s2))
      )

    )
  )
  ;; After validating all arcs move all corresponding arcs
  ;; Can only be executing after validation (check_added_variables)
  (:action add_move_automata
      :parameters (?a - activity)
      :precondition (and 
        (complete_sync ?a)
        (not (after_add))
        (after_add_check)
        
        ;; Only execute if there is an arc that leads to a state that's not a fail state
        ;; and only move if the automata are not already all satisfying
        ;; -> this reduces the amount of possible (non-optimal) solutions.
        (exists (?s1 - automaton_state ?s2 - automaton_state) 
          (and
            (not (goal_state ?s1))
            (not (invalid ?s1 ?a ?s2))
            (cur_s_state ?s1)
            (automaton ?s1 ?a ?s2)
            (not (failure_state ?s2))
          )
        )
      
        )
      :effect (and 
        (increase (total_cost) 0)

        ;(increase (current_timestamp)0.1)
        (not (after_add_check))

      
        ;; Move all automata, starting with the arcs leading to non-fail states
        (forall (?s1 - automaton_state ?s2 - automaton_state)
          (when (and
            (automaton ?s1 ?a ?s2)
            (cur_s_state ?s1)
            (not (failure_state ?s2))
            (not (invalid ?s1 ?a ?s2))
            ) 
            (and
              (not (cur_s_state ?s1))
              (cur_s_state ?s2)
            )
          )
        )

      (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint)
        (when (and
          (not (invalid ?s1 ?a ?s2))
          (automaton ?s1 ?a ?s2)
          (cur_s_state ?s1)
          (failure_state ?s2)
          (associated ?s1 ?c)
          (associated ?s2 ?c)
        ) (and
          (not (cur_s_state ?s1))
          (cur_s_state ?s2)
          (failure)
          (violated ?c)
        ))
      )

     

      ;; Reset the flag that a payload is added
      ;; Needed since the same activity could be added multiple times with different values
      ;; Not possible to reset a numeric fluent to undefined, as it HAS to be set at the end of the plan if it gets set at any point
      (forall (?s1 - automaton_state ?pn - parameter_name)
            (when (has_added_parameter_aut ?a ?pn ?s1) (not (has_added_parameter_aut ?a ?pn ?s1)))
      )

      ;; Reset all Arcs so we can insert the same activity multiple times.
      (forall (?s1 - automaton_state ?s2 - automaton_state)
        (when
          (and 
          (automaton ?s1 ?a ?s2)
          (invalid ?s1 ?a ?s2)
          )
          (not (invalid ?s1 ?a ?s2)) )
      )


      (not (complete_sync ?a))
  )
  )

  ;; SYNC OPERATIONS
  ;; ----------------------------------------------------------------------------------------------------
  ;; Action 'validate-payload' checks if the guards are satisfied
  ;; It sets all arcs that are "enabled" to '(not (invalid))',
  ;; and all disabled arcs to "invalid"
  (:action validate-payload
      :parameters (?t1 - trace_state ?a - activity ?t2 - trace_state)
      :precondition (and 
        (cur_t_state ?t1) 
        (trace ?t1 ?a ?t2) 
        (not (after_sync))
        (not (after_add))
        (not (failure))
        (not (complete_sync ?a))
        (not (after_add_check))
        ;(= current_timestamp (timestamp ?t1 ?t2))
        ; has_increased indicates if the waiting time has been increased
        ; only possible when adding, not when synching
        
        ;; I split up the violation flag in two steps
        ;; If I only say "not failure" it might keep a constraint violated if multiple become violated at the same time
        (not (exists (?c - constraint) 
          (violated ?c)
        ))
        
        (not (recovery_finished))

        ;(exists (?s1 - automaton_state ?s2 - automaton_state ) 
        ;  (and
        ;    (cur_s_state ?s1)
        ;    (not (failure_state ?s1))
        ;    (not (goal_state ?s1))
        ;    (automaton ?s1 ?a ?s2)
        ;    (not (invalid ?s1 ?a ?s2))
        ;    ;(not (failure_state ?s2))
        ;  )
        ;)
        
        )
      :effect (and 
          (increase (total_cost) 0)
          (after_sync)
          ;Check if case parameter is missing
          ;; The "nested" when seems to save time as we do not need to iterate 6+ times over all combinations
          (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state)
            ;  ; If parameter is missing
            (when 
              (and 
              ;(not (invalid ?s1 ?a ?s2))
                (cur_s_state ?s1)
                (automaton ?s1 ?a ?s2)
                (has_constraint ?a ?pn ?s1 ?s2)
                (or
                  (not (has_parameter ?a ?pn ?t1 ?t2))
                  (< (trace_parameter ?a ?pn ?t1 ?t2) (majority_constraint ?a ?pn ?s1 ?s2))
                  (> (trace_parameter ?a ?pn ?t1 ?t2) (minority_constraint ?a ?pn ?s1 ?s2))
                  (< (trace_parameter ?a ?pn ?t1 ?t2) (interval_constraint_lower ?a ?pn ?s1 ?s2))
                  (> (trace_parameter ?a ?pn ?t1 ?t2) (interval_constraint_higher ?a ?pn ?s1 ?s2))
                  (< (trace_parameter ?a ?pn ?t1 ?t2) (equality_constraint ?a ?pn ?s1 ?s2))
                  (> (trace_parameter ?a ?pn ?t1 ?t2) (equality_constraint ?a ?pn ?s1 ?s2))
                  (= (trace_parameter ?a ?pn ?t1 ?t2) (inequality_constraint ?a ?pn ?s1 ?s2))
                )
              )
              
              (invalid ?s1 ?a ?s2)
            )
          )   

        )
      )
  
  ;; Move automaton according to the enabled arcs decided in "validate-payload"
  (:action sync-actions
    :parameters (?t1 ?t2 - trace_state ?a - activity)
    :precondition (and 
      
      (not (after_add))
      (not (failure))
      (not (after_add_check))
      (not (complete_sync ?a))
      ;(= current_timestamp (timestamp ?t1 ?t2))
      (after_sync)

      (cur_t_state ?t1)
      (trace ?t1 ?a ?t2)     

      ;(exists (?s1 - automaton_state ?s2 - automaton_state) 
      ;  (and
      ;  (cur_s_state ?s1)
      ;  ;(not (goal_state ?s1))
      ;  ;(not (failure_state ?s1))
      ;  (automaton ?s1 ?a ?s2)
      ;  ;(not (invalid ?s1 ?a ?s2))
      ;  ;(not (failure_state ?s2))
      ;  )
      ;)
      
 )

    :effect (and 
      (increase (total_cost) 0)


      (not (cur_t_state ?t1)) 
      (cur_t_state ?t2)
      (when (final_t_state ?t2) (recovery_finished))
      (not (after_sync))
      ;(assign (current_timestamp) (timestamp ?t1 ?t2))
      
      ; Move all enabled automata that are ending in a valid state
      (forall (?s1 - automaton_state ?s2 - automaton_state)
        (when (and
          (not (invalid ?s1 ?a ?s2))
          (automaton ?s1 ?a ?s2)
          (cur_s_state ?s1)
          (not (failure_state ?s2))
        ) (and
          (not (cur_s_state ?s1))
          (cur_s_state ?s2)
        ))
      )

      ; Move all enabled automata that are ending in a fail state
      (forall (?s1 - automaton_state ?s2 - automaton_state ?c - constraint)
        (when (and
          (not (invalid ?s1 ?a ?s2))
          (automaton ?s1 ?a ?s2)
          (cur_s_state ?s1)
          (failure_state ?s2)
          (associated ?s1 ?c)
          (associated ?s2 ?c)
        ) (and
          (not (cur_s_state ?s1))
          (cur_s_state ?s2)
          (failure)
          (violated ?c)
        ))
      )

      (forall (?s1 - automaton_state ?s2 - automaton_state) 
        (when (and 
          (invalid ?s1 ?a ?s2)
          (automaton ?s1 ?a ?s2)
          ) ; Without the when enclosing, it crashes.
          (not (invalid ?s1 ?a ?s2))
        )
      )
    )
  )


  (:action validate-failure
      :parameters (?c - constraint)
      :precondition (and
          ;(failure)
          (not (after_sync))
          (not (after_add))
          (not (after_add_check))

          (exists (?s1 - automaton_state)
          (and
          (cur_s_state ?s1)
          (associated ?s1 ?c)
          (not (goal_state ?s1))
          ;(failure_state ?s1)
          
          )
           )
         )
      :effect (and 
      ;; Allow the reset at any state
      ;; Possibly relevant to abort early

        ;(forall (?s1 - automaton_state) 
        ;(when (and
        ;  (cur_s_state ?s1)
        ;  (associated ?s1 ?c)
        ;  (not (goal_state ?s1))
        ;;(failure_state ?s1)
        ;) 
        ;(violated ?c))
        ;)

        (violated ?c)
      )
  )
  


  (:action reset
      :parameters (?c - constraint)
      :precondition (and 
          (violated ?c)
          ;(failure)
          ;(not (after_sync))
          ;(not (after_add))
          ;(not (after_add_check))
          )
      :effect (and 

      (increase (total_cost) (violation_cost ?c))
      
      (forall (?s1 ?s2 - automaton_state)
        (when (and
            (cur_s_state ?s1)
            (not (goal_state ?s1))
            ;(failure_state ?s1)
            (initial_state ?s2)
            (associated ?s1 ?c)
            (associated ?s2 ?c)
            (not (failure_state ?s2))
            )
            (and
            (not (cur_s_state ?s1))
            (cur_s_state ?s2)
            )  
        )
        )
      (not (failure))
      (not (violated ?c))
      )
  )
)