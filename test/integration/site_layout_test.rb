# リスト 5.32:レイアウトのリンクに対するテスト green
# test/integration/site_layout_test.rb

require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'static_pages/home' #該当ビューが正しくテストできているか
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
  end
end


# 今回の目的は、アプリケーションのHTML構造を調べて、レイアウトの各リンクが正しく動くかどうかチェックすることです。つまり、
  # 1:ルートURL (Homeページ) にGETリクエストを送る.
  # 2:正しいページテンプレートが描画されているかどうか確かめる.
  # 3:Home、Help、About、Contactの各ページへのリンクが正しく動くか確かめる.

# Railsの統合テストでは、上のステップをコードに落とし込んでいくことになります (リスト 5.32)。
# 具体的には、まずassert_templateメソッドを使って、
# Homeページが正しいビューを描画しているかどうか確かめます16 。

# https://qiita.com/zizynonno/items/160ace78b2dd5fc61d73






# require 'test_helper'

# class SiteLayoutTest < ActionDispatch::IntegrationTest
#   # test "the truth" do
#   #   assert true
#   # end
# end
