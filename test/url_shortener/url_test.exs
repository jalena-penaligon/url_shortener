defmodule UrlShortener.UrlTest do
  use UrlShortener.DataCase

  alias UrlShortener.Url

  describe "shorteners" do
    alias UrlShortener.Url.Shortener

    @valid_attrs %{long_url: "some long_url", short_url: "some short_url"}
    @update_attrs %{long_url: "some updated long_url", short_url: "some updated short_url"}
    @invalid_attrs %{long_url: nil, short_url: nil}

    def shortener_fixture(attrs \\ %{}) do
      {:ok, shortener} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Url.create_shortener()

      shortener
    end

    test "list_shorteners/0 returns all shorteners" do
      shortener = shortener_fixture()
      assert Url.list_shorteners() == [shortener]
    end

    test "get_shortener!/1 returns the shortener with given id" do
      shortener = shortener_fixture()
      assert Url.get_shortener!(shortener.id) == shortener
    end

    test "create_shortener/1 with valid data creates a shortener" do
      assert {:ok, %Shortener{} = shortener} = Url.create_shortener(@valid_attrs)
      assert shortener.long_url == "some long_url"
      assert shortener.short_url == "some short_url"
    end

    test "create_shortener/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Url.create_shortener(@invalid_attrs)
    end

    test "update_shortener/2 with valid data updates the shortener" do
      shortener = shortener_fixture()
      assert {:ok, %Shortener{} = shortener} = Url.update_shortener(shortener, @update_attrs)
      assert shortener.long_url == "some updated long_url"
      assert shortener.short_url == "some updated short_url"
    end

    test "update_shortener/2 with invalid data returns error changeset" do
      shortener = shortener_fixture()
      assert {:error, %Ecto.Changeset{}} = Url.update_shortener(shortener, @invalid_attrs)
      assert shortener == Url.get_shortener!(shortener.id)
    end

    test "delete_shortener/1 deletes the shortener" do
      shortener = shortener_fixture()
      assert {:ok, %Shortener{}} = Url.delete_shortener(shortener)
      assert_raise Ecto.NoResultsError, fn -> Url.get_shortener!(shortener.id) end
    end

    test "change_shortener/1 returns a shortener changeset" do
      shortener = shortener_fixture()
      assert %Ecto.Changeset{} = Url.change_shortener(shortener)
    end
  end
end
