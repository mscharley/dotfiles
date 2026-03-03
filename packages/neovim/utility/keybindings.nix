{ ... }:
{
	vim.keymaps = [
		# Navigate by visual line instead of logical line
		{
			mode = "n";
			key = "<up>";
			action = "gk";
		}
		{
			mode = "n";
			key = "<down>";
			action = "gj";
		}

		# Move line up/down
		{
			desc = "Move line up";
			mode = "n";
			key = "<A-up>";
			action = "ddkP";
		}
		{
			desc = "Move line down";
			mode = "n";
			key = "<A-down>";
			action = "ddp";
		}

		# Navigate between split buffers
		{
			mode = "n";
			key = "<C-A-up>";
			action = "<C-w><up>";
		}
		{
			mode = "n";
			key = "<C-A-down>";
			action = "<C-w><down>";
		}
		{
			mode = "n";
			key = "<C-A-left>";
			action = "<C-w><left>";
		}
		{
			mode = "n";
			key = "<C-A-right>";
			action = "<C-w><right>";
		}

		# Split buffers
		{
			desc = "Split screen (vertical)";
			mode = "n";
			key = "<leader>\"";
			action = "<Cmd>vsplit<CR>";
		}
		{
			desc = "Split screen (horizontal)";
			mode = "n";
			key = "<leader>%";
			action = "<Cmd>split<CR>";
		}

		# Move to previous/next tab
		{
			desc = "View buffer left";
			mode = "n";
			key = "<A-,>";
			action = "<Cmd>BufferPrevious<CR>";
		}
		{
			desc = "View buffer right";
			mode = "n";
			key = "<A-.>";
			action = "<Cmd>BufferNext<CR>";
		}

		# Re-order to previous/next tab
		{
			desc = "Move buffer left";
			mode = "n";
			key = "<D-A-,>";
			action = "<Cmd>BufferMovePrevious<CR>";
		}
		{
			desc = "Move buffer right";
			mode = "n";
			key = "<D-A-.>";
			action = "<Cmd>BufferMoveNext<CR>";
		}

		# Close buffer
		{
			desc = "Close buffer";
			mode = "n";
			key = "<A-q>";
			action = "<Cmd>BufferClose<CR>";
		}
	];
}
