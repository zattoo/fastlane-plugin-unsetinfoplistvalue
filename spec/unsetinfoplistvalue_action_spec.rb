describe Fastlane::Actions::UnsetinfoplistvalueAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The unsetinfoplistvalue plugin is working!")

      Fastlane::Actions::UnsetinfoplistvalueAction.run(nil)
    end
  end
end
