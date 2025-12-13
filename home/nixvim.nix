{ pkgs,... }:
{
  programs.nixvim = {
    enable = true;
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = [ pkgs.imagemagick ];

    defaultEditor = true;

    globals = {
      mapleader = " ";
      maplocalleader = ",";
    };

    plugins.lsp.servers.pyright.enable = true;

    keymaps = [
      { mode = "n"; key = "tn";    action = "<cmd>tabnew<cr>";      options.silent = true; }
      { mode = "n"; key = "tq";    action = "<cmd>tabclose<cr>";    options.silent = true; }
      { mode = "n"; key = "<C-h>"; action = "<cmd>tabprevious<cr>"; options.silent = true; }
      { mode = "n"; key = "<C-l>"; action = "<cmd>tabnext<cr>";     options.silent = true; }

      { mode = "n"; key = "<localleader>mi"; action = "<cmd>MoltenInit<CR>";
        options = { silent = true; desc = "Initialize the plugin"; }; }
      { mode = "n"; key = "<localleader>e";  action = "<cmd>MoltenEvaluateOperator<CR>";
        options = { silent = true; desc = "run operator selection"; }; }
      { mode = "n"; key = "<localleader>rl"; action = "<cmd>MoltenEvaluateLine<CR>";
        options = { silent = true; desc = "evaluate line"; }; }
      { mode = "n"; key = "<localleader>rr"; action = "<cmd>MoltenReevaluateCell<CR>";
        options = { silent = true; desc = "re-evaluate cell"; }; }
      { mode = "v"; key = "<localleader>r";  action = ":<C-u>MoltenEvaluateVisual<CR>gv";
        options = { silent = true; desc = "evaluate visual selection"; }; }
    ];

    plugins = {
      lsp.enable = true;
      treesitter.enable = true;
      molten = {
        enable = true;
        settings = {
          auto_image_popup = false;
          auto_init_behavior = "init";
          auto_open_html_in_browser = false;
          auto_open_output = true;
          cover_empty_lines = false;
          copy_output = false;
          enter_output_behavior = "open_then_enter";
          image_provider = "image.nvim";
          output_crop_border = true;
          output_virt_lines = false;
          output_win_border = [ "" "━" "" "" ];
          output_win_hide_on_leave = true;
          output_win_max_height = 10000;
          output_win_max_width = 10000;
          save_path.__raw = "vim.fn.stdpath('data')..'/molten'";
          tick_rate = 500;
          use_border_highlights = false;
          limit_output_chars = 10000;
          wrap_output = false;
        };
      };

     # 画像描画用（Kitty backend）
     image = {
       enable = true;
       backend = "kitty";
       settings = {
        max_width = null;
        max_height = null;

        max_width_window_percentage = 50;
        max_height_window_percentage = 50;

       };
     };

      # Completion
      luasnip.enable = true;
      "cmp-nvim-lsp".enable = true;
      cmp = {
        enable = true;
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        mapping = {
          "<Tab>"    = "cmp.mapping.select_next_item()";
          "<S-Tab>"  = "cmp.mapping.select_prev_item()";
          "<CR>"     = "cmp.mapping.confirm({ select = true })";
          "<C-Space>"= "cmp.mapping.complete()";
        };
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        completion = { completeopt = "menu,menuone,noselect"; };
      };
    };
  };
}
