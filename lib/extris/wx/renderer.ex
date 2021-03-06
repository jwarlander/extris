defmodule Extris.Wx.Renderer do
  use Extris.Wx.Imports
  alias Extris.Shapes

  @side 25.0

  def draw(state, {dc, canvas}) do
    :wxPaintDC.clear(dc)
    do_draw(state, canvas)
  end

  def do_draw(state, canvas) do
    pen = :wx_const.wx_black_pen
    :wxGraphicsContext.setPen(canvas, pen)
    draw_board(canvas, state)
  end

  def draw_square(canvas, x, y, brush) do
    :wxGraphicsContext.setBrush(canvas, brush)
    true_x = @side * x
    true_y = @side * y
    :wxGraphicsContext.drawRectangle(canvas, true_x, true_y, @side, @side)
  end

  def brush_for(:ell),   do: :wxBrush.new({255, 150, 0, 255})
  def brush_for(:jay),   do: :wxBrush.new({12, 0, 255, 255})
  def brush_for(:ess),   do: :wxBrush.new({5, 231, 5, 255})
  def brush_for(:zee),   do: :wxBrush.new({255, 17, 17, 255})
  def brush_for(:bar),   do: :wxBrush.new({0, 240, 255, 255})
  def brush_for(:oh),    do: :wxBrush.new({247, 255, 17, 255})
  def brush_for(:tee),   do: :wxBrush.new({100, 255, 17, 255})
  def brush_for(:board), do: :wxBrush.new({0, 0, 0, 255})

  def draw_board(canvas, state) do
    draw_frame(canvas, state)
    for {row, row_i} <- Enum.with_index(state.board) do
      for {col, col_i} <- Enum.with_index(row) do
        case col do
          0 -> true
          n -> draw_square(canvas, col_i, row_i, brush_for(Shapes.by_number(n)))
        end
      end
    end
  end

  def draw_frame(canvas, state) do
    brush = brush_for(:board)
    board_width = Shapes.width(state.board)
    board_height = Shapes.height(state.board)
    for x <- (0..board_width) do
      draw_square(canvas, x, board_height, brush)
    end
    for y <- (0..board_height) do
      draw_square(canvas, 0, y, brush)
      draw_square(canvas, board_width, y, brush)
    end
  end
end
