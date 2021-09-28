# DB-project 11 team KCR

프로젝트 주제 : COVID-19 감염자 데이터베이스

기획 의도 : 요즘 코로나19 감염자가 폭증하고 있는 상황에서 감염자들의 데이터를 저장하여 관리하는 시스템이 있으면 편리할 것 같아 만들게 되었습니다.

프로젝트 설명 : 저희 11팀 KCR은 KNU Covid-19 Reserch로 기획 의도와 같이 코로나 감염자들의 데이터를 저장하여 관리하는 시스템을 만들어 모든 사용자들이 코로나19 감염자들의 정보를 편하게 볼 수 있게 만드는 것이 목적입니다.( 개념적 설계만 진행된 관계로 추후 업데이트 예정)

ER 다이어그램 : ER 다이어그램은 총 7개의 Entity로 구성되어 있으며 그중 3개의 Weak Entity를 포함하고 있습니다.

Entity 설명 :

PATIENT : 코로나19 감염된 환자들의 정보로 이름, 주민번호, 성별, 전화번호 그리고 나이로 구성되어 있습니다. 환자가 치료받는 병원, 환자가 거주하고 있는 지역, 환자의 최근 이동경로, 환자의 완치 여부, 환자의 증상 그리고 환자의 주변 사람들과 관계가 되어있습니다.

1. REGION : 코로나19 감염된 환자의 위치정보이며 지역 고유번호, 시 그리고 구로 구성되어 있습니다. 그 지역에 존재하는 병원들과 환자가 거주했던 곳과 관계가 되어있습니다.
2. HOSPITAL : 환자들을 치료하는 병원으로 병원 고유번호, 병원 이름, 병원 전화번호 그리고 병원 주소로 구성되어 있습니다. 지역단위로 병원이 있기에 지역과 관계돼있고, 입원한 환자들과 관계가 되어있습니다.
3. RECOVERY : 환자가 완치됐는지 확인을 하는 Entity로 환자가 있어야 치료가 이루어질 수 있기 때문에 Weak Entity로 구성했습니다. 치료 번호와 치료방법들이 속성으로 있으며 환자와 관계가 되어있습니다. 또한 완치된 날짜를 기록하기 위하여 관계 GET에 finish_date의 속성을 추가하였습니다.
4. SYMPTOM : 감염의 증상으로 증상의 이름으로 구성되어 있으며 예를 들면 목 아픔, 몸살, 기침 등이 있습니다. 감염 증상이기에 환자와 관계되어 있습니다. 또한 증상이 시작된 날짜를 기록하기 위하여 관계 HAS에 start_date의 속성을 추가하였습니다.
5. PATH : 환자의 최근 이동경로를 기록하는 Entity로 환자가 없으면 환자의 이동경로는 존재할 수 없기에 Weak Entity로 구성했습니다. 환자의 이동경로를 기록하기에 환자와 관계되어 있습니다.
6. BUBBLE : 환자가 감였됐을 당시의 주변 사람들(소모임) 그리고 환자의 주변인들을 확인하는 Entity로 주민번호, 이름, 성별 그리고 나이를 구성하고 있으며 환자의 주변 사람들이니 환자가 없으면 존재할 수 없기에 Weak Entity로 구성하였습니다. 환자의 주변 사람들이기에 환자와 관계되어 있습니다

Cardinality Ratio 설명

1. 각 환자들은 한 지역에 살고 있지만 지역에는 많은 환자가 있을 수 있어서 1:N이다.
2. 각 환자들은 여러 모임에 포함되어 있을 수 있다. 따라서 1:N의 관계이다.
3. 각 환자들은 자기가 최근 다녀온 경로가 있다. 따라서 1:1 관게이다.
4. 각 환자들은 하나 이상의 증상을 가질 수 있다. 따라서 M:N 관계이다.
5. 각 환자들은 완치될 수 있다. 따라서 1:1 관계이다.
6. 각 환자들은 한 병원에 입원하고 병원에는 많은 환자가 입원한다. 따라서 N:1의 관계이다.
7. 각 병원은 하나의 지역에 위치하지만 한 지역에는 많은 병원이 존재한다. 따라서 N:1 관계이다.
