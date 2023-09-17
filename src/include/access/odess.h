#include <array>

struct SimilarityFeatures {
  uint64_t feature1;
  uint64_t feature2;
  uint64_t feature3;
};

class Odess {
 public:
  Odess();
  ~Odess() = default;
  SimilarityFeatures Calculation(uint8_t*, uint64_t);

 private:
  std::array<int, 12> kArray;
  std::array<int, 12> bArray;
  std::array<uint64_t, 12> maxList;
  static std::array<uint64_t, 256> gearMatrix;
};