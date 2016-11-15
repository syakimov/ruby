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
        expect(version.to_s).to eq ''
        expect(version).to eq Version.new('0')
      end

      it 'creates a version when passed empty string' do
        version = Version.new('')
        expect(version.to_s).to eq ''
        expect(version).to eq Version.new('0')
      end

      it 'creates a version when nothing is passed' do
        version = Version.new
        expect(version.to_s).to eq ''
        expect(version).to eq Version.new('0')
      end

      it 'creates an instance from another version' do
        parameter = Version.new('1.1.1')
        version = Version.new(parameter)
        expect(version.to_s).to eq '1.1.1'
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
end
