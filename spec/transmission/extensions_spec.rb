describe Transmission::Model::Torrent do
  describe 'extensions' do
    let(:torrent) { Transmission::Model::Torrent.new([{
      'name' => 'ubuntu-16.04.1-desktop-amd64.iso',
      'downloadDir' => '/home/user/downloads',
      'id' => 1,
      'hashString' => '9f9165d9a281a9b8e782cd5176bbcc8256fd1871'
    }], nil) }

    describe 'with any torrent' do
      it 'should have a name' do
        expect(torrent.name).not_to be_nil
        expect(torrent.name).to be_a(String)
      end

      it 'should have a path' do
        expect(torrent.path).not_to be_nil
        expect(torrent.path).to eq(
          '/home/user/downloads/ubuntu-16.04.1-desktop-amd64.iso'
        )
      end

      it 'should have an hash' do
        expect(torrent.hash).not_to be_nil
      end
    end
  end
end
