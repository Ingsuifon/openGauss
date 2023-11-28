#include <array>

struct SimilarityFeatures {
    uint64_t feature[12];

    bool operator==(const SimilarityFeatures &other) const
    {
        for (int i = 0; i < 3; i++) {
            if (feature[i] == other.feature[i])
                return true;
        }
        return false;
    }
};

class Odess {
public:
    SimilarityFeatures Calculation(uint8_t *, uint64_t, uint64_t headerLength = 0, uint64_t skipLength = 0);

private:
    std::array<uint64_t, 12> maxList;
    static std::array<int, 12> kArray;
    static std::array<int, 12> bArray;
    static std::array<uint64_t, 256> gearMatrix;
};