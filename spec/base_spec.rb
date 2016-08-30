require "spec_helper"

module RaiseRecordNotUnique
  def create(*args, &block)
    super and raise ActiveRecord::RecordNotUnique
  end

  def create!(*args, &block)
    super and raise ActiveRecord::RecordNotUnique
  end
end

describe RetryableFindOrCreateBy do
  let (:user) do
    user = User.all
    user.extend RaiseRecordNotUnique
  end

  it "`find_or_create_by` should retry when `create` raises `RecordNotUnique`" do
    allow(user).to receive(:find_by).twice.and_call_original
    expect(user.find_or_create_by(name: "hoge")).not_to be_nil
  end

  it "`find_or_create_by!` should retry when `create!` raises `RecordNotUnique`" do
    allow(user).to receive(:find_by).twice.and_call_original
    expect(user.find_or_create_by!(name: "fuga")).not_to be_nil
  end

  it "`first_or_create` should retry when `create` raises `RecordNotUnique`" do
    allow(user).to receive(:first).twice.and_call_original
    expect(user.first_or_create(name: "hoge")).not_to be_nil
  end

  it "`first_or_create!` should retry when `create!` raises `RecordNotUnique`" do
    allow(user).to receive(:first).twice.and_call_original
    expect(user.first_or_create!(name: "hoge")).not_to be_nil
  end
end
