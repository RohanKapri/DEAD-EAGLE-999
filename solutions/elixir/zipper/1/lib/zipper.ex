defmodule Zipper do
  @type t :: %Zipper{node: BinTree.t(), parents: list() | nil}
  defstruct node: nil, parents: [ ]
  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree) do
    %Zipper{node: bin_tree}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(%Zipper{node: bin_tree, parents: []}) do
    bin_tree
  end

  def to_tree(%Zipper{} = zipper) do
    zipper |> up() |> to_tree()
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(%Zipper{node: node}) do
    node.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(%Zipper{node: %{left: nil}}) do
    nil
  end

  def left(%Zipper{node: node, parents: parents}) do
    %Zipper{node: node.left, parents: [{:left, node} | parents]}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(%Zipper{node: %{right: nil}}) do
    nil
  end

  def right(%Zipper{node: node, parents: parents}) do
    %Zipper{node: node.right, parents: [{:right, node} | parents]}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%Zipper{parents: []} ) do
    nil
  end

  def up(%Zipper{node: node, parents: [{direction, up} | parents]}) do
    %Zipper{node: Map.put(up, direction, node), parents: parents}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(%Zipper{node: node, parents: _parents} = zipper, value) do
    %Zipper{zipper | node: %BinTree{node | value: value}}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(%Zipper{node: node, parents: _parents} = zipper, left) do
    %Zipper{zipper | node: %BinTree{node | left: left}}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(%Zipper{node: node, parents: _parents} = zipper, right) do
    %Zipper{zipper | node: %BinTree{node | right: right}}
  end
end





defmodule BinTree do
  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """

  @type t :: %BinTree{value: any, left: t() | nil, right: t() | nil}

  defstruct [:value, :left, :right]
end

defimpl Inspect, for: BinTree do
  import Inspect.Algebra

  # A custom inspect instance purely for the tests, this makes error messages
  # much more readable.
  #
  # For example:
  #
  # - %BinTree{value: 3, left: nil, right: nil}
  #   becomes
  #   (3::)
  #
  # - %BinTree{value: 3, left: nil, right: %BinTree{value: 5}}
  #   becomes
  #   (3::(5::))
  #
  # - %BinTree{value: 3, left: %BinTree{value: 1}, right: %BinTree{value: 5}}
  #   becomes
  #   (3:(1::):(5::))

  def inspect(%BinTree{value: value, left: left, right: right}, opts) do
    concat([
      "(",
      to_doc(value, opts),
      ":",
      if(left, do: to_doc(left, opts), else: ""),
      ":",
      if(right, do: to_doc(right, opts), else: ""),
      ")"
    ])
  end
end