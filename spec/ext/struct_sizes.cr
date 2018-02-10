require "../spec_helper"

describe "struct sizes" do
  it "rte_mbuf" do
    sizeof(LibDpdk::RteMbuf).should eq(128)
  end
  it "rte_mempool" do
    sizeof(LibDpdk::RteMempool).should eq(192)
  end
  it "rte_ring" do
    sizeof(LibDpdk::RteRing).should eq(384)
  end
end
