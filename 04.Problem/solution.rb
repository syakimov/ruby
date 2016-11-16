require_relative 'version'

RSpec.describe 'Version' do
  describe '#initialize' do
    context 'with valid input' do
      it 'creates a version beginning with zeros' do
        expect(Version.new('0.1.1').to_s).to eq '0.1.1'
      end

      it 'creates a version eding with zeros' do
        expect(Version.new('1.0.0').to_s).to eq '1'
      end

      it 'creates a version when zero is passed' do
        version = Version.new('0.0')
        expect(version).to eq Version.new('0')
      end

      it 'creates a version when passed empty string' do
        version = Version.new('')
        expect(version).to eq Version.new('0')
      end

      it 'creates a version when nothing is passed' do
        version = Version.new
        expect(version).to eq Version.new('0')
      end

      it 'creates an instance from another version' do
        parameter = Version.new('1.1.1')
        version = Version.new(parameter)
        expect(version).to eq parameter
      end
    end

    context 'with invalid input' do
      it 'throws an error when invalid symbol is passed' do
        invalid_symbols = "!\"#$%&'()*+,-/:;<=>?@[\\]^_`".split('')
        invalid_symbols.each do |sym|
          expect do
            Version.new("1#{sym}1")
          end.to raise_error(ArgumentError, "Invalid version string '1#{sym}1'")
        end
      end

      it 'throws an error when missing numbers are passed' do
        expect do
          Version.new('.3')
        end.to raise_error(ArgumentError, "Invalid version string '.3'")

        expect do
          Version.new('3..0')
        end.to raise_error(ArgumentError, "Invalid version string '3..0'")

        expect do
          Version.new('3.')
        end.to raise_error(ArgumentError, "Invalid version string '3.'")

        expect do
          Version.new('.')
        end.to raise_error(ArgumentError, "Invalid version string '.'")
      end

      it 'throws an error when non integer is passed' do
        expect do
          Version.new('a.a')
        end.to raise_error(ArgumentError, "Invalid version string 'a.a'")
      end
    end
  end
  describe '#<=>' do
    context 'equal versions' do
      it 'compares equal version' do
        expect(Version.new('1.1')).to eq Version.new('1.1')
      end

      it 'returns true when same versions with diff length are compared' do
        expect(Version.new('1.1.0')).to eq Version.new('1.1')
      end

      it 'returns true when zero versions are compared' do
        expect(Version.new('0')).to eq Version.new('0')
      end
    end

    context 'non equal versions' do
      it 'returns false when versions with zeros upfront are compared' do
        expect(Version.new('0.1.1')).not_to eq Version.new('1.1')
      end

      it 'returns false when symetric versions are compared' do
        expect(Version.new('1.2.3')).not_to eq Version.new('3.2.1')
      end
    end

    context 'compare version' do
      it 'compares correctly versions with diff length' do
        expect(Version.new('1.3') > Version.new('1.2.4')).to be_truthy
      end

      it 'compares correctly versions with zeros at the end' do
        expect(Version.new('1.3.0.0') > Version.new('1.2')).to be_truthy
      end

      it 'compares correctly versions with zeros at the beginning' do
        expect(Version.new('0.1.3') < Version.new('0.1.4')).to be_truthy
      end
    end
  end
  describe '#to_s' do
    it 'does not remove zeros from the beginning' do
      expect(Version.new('0.1').to_s).to eq '0.1'
    end

    it 'removes zeros from the end' do
      expect(Version.new('1.0').to_s).to eq '1'
    end

    it 'returns empty string from zero version' do
      expect(Version.new.to_s).to eq ''
    end
  end
  describe '#components' do
    context 'without option parameter' do
      it 'should not raise error since the param is optional' do
        version = Version.new('')
        # this should not raise error
        version.components
      end
    end

    context 'with optional parameter' do
      it 'when components length < N adds zeros' do
        version = Version.new('1')
        expect(version.components(3)).to eq [1, 0, 0]
      end

      it 'when components length > N returns first N' do
        version = Version.new('1.2.3')
        expect(version.components(2)).to eq [1, 2]
      end
    end
  end
end
