; extends
(
  (short_var_declaration
    left: (expression_list
      (identifier) @injection.variable
    )
    right: (expression_list
      (raw_string_literal
        (raw_string_literal_content) @injection.content
      )
    )
  )
  (#eq? @injection.variable "query")
  (#set! injection.language "sql")
)


(
  (short_var_declaration
    left: (expression_list
      (identifier) @injection.variable
    )
    right: (expression_list 
      (call_expression
        function: (selector_expression 
          operand: (identifier)
          field: (field_identifier)
        )
        arguments: (argument_list 
          (raw_string_literal 
            (raw_string_literal_content) @injection.content
          )
        )
      )
    )
  )
  (#eq? @injection.variable "query")
  (#set! injection.language "sql")
)
