return {
  {
    'seblyng/roslyn.nvim',
    ft = { 'cs', 'razor' },
    config = function(_, opts)
      require('roslyn').setup(opts)
    end,
    opts = {
      broad_search = true,
      settings = {
        ['csharp|background_analysis'] = {
          dotnet_analyzer_diagnostics_scope = 'fullSolution',
          dotnet_compiler_diagnostics_scope = 'fullSolution',
        },
        ['csharp|completion'] = {
          dotnet_show_completion_items_from_unimported_namespaces = true,
        },
        ['csharp|symbol_search'] = {
          dotnet_search_reference_assemblies = true,
        },
        ['csharp|inlay_hints'] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
        },
        ['csharp|code_lens'] = {
          dotnet_enable_references_code_lens = true,
        },
      },
    },
  },
}
