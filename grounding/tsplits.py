text = """(and 
      ;; Allow the reset at any state
      ;; Possibly relevant to abort early
        (forall (?s1 - automaton_state) 
        (when (and
          (cur_s_state ?s1)
          (associated ?s1 ?c)
          (not (goal_state ?s1))
        ;(failure_state ?s1)
        ) 
        (violated ?c))
        )
      )"""


compressed = ' '.join(text.split())
print(compressed)