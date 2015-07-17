module Fixtures
  def fixture(file)
    File.read(Rails.root.join('spec/fixtures/', file))
  end

  def txt_fixture(file)
    fixture(file + '.txt')
  end
end
