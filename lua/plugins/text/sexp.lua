require("lz.n").load {
  {
    "sexp.nvim",
    ft = { "clojure", "fennel", "lisp", "scheme", "timl" },
    before = function() vim.cmd.packadd "vim-repeat" end,
    after = function()
      require("sexp").setup {
        enable_insert_mode_mappings = false,
        insert_after_wrap = true,
        mappings = {
          sexp_round_head_wrap_element = "<LocalLeader>(",
          sexp_round_tail_wrap_element = "<LocalLeader>)",
          sexp_square_head_wrap_element = "<LocalLeader>[",
          sexp_square_tail_wrap_element = "<LocalLeader>]",
          sexp_curly_head_wrap_element = "<LocalLeader>{",
          sexp_curly_tail_wrap_element = "<LocalLeader>}",
          sexp_splice_list = "<LocalLeader>S",
          sexp_raise_element = "<LocalLeader>R",
          sexp_swap_element_backward = "<LocalLeader>T",
          sexp_swap_element_forward = "<LocalLeader>t",
          sexp_emit_head_element = "<LocalLeader>hb",
          sexp_emit_tail_element = "<LocalLeader>lb",
          sexp_capture_prev_element = "<LocalLeader>hs",
          sexp_capture_next_element = "<LocalLeader>ls",
        },
      }
    end,
  },
}
