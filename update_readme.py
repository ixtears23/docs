import os
import subprocess
from datetime import datetime

def get_git_creation_date(file_path):
    try:
        # git log 명령을 사용하여 파일의 최초 커밋 날짜를 가져옵니다.
        date_str = subprocess.check_output(
            ['git', 'log', '--diff-filter=A', '--', file_path],
            universal_newlines=True,
        ).split('\n')[2].split('   ')[1]

        # 날짜 문자열을 datetime 객체로 변환합니다.
        date = datetime.strptime(date_str, '%c %z')
        return date.strftime('%Y-%m-%d')
    except Exception as e:
        # git log 명령이 실패하면 None을 반환합니다.
        print(f"Error getting creation date for {file_path}: {e}")
        return None

# README 파일을 생성할 디렉토리를 지정합니다.
project_dir = '.'

# 프로젝트의 폴더명을 가져와 제목으로 설정합니다.
project_title = os.path.basename(os.path.abspath(project_dir))

# README.md 파일을 쓰기 모드로 엽니다.
with open('README.md', 'w') as readme_file:
    # 프로젝트의 타이틀을 작성합니다.
    readme_file.write(f'# {project_title}\n\n')

    # project_dir에서 모든 파일과 디렉토리를 나열합니다.
    for foldername, subfolders, filenames in os.walk(project_dir):

        # /img로 끝나는 디렉토리와 .idea 및 .git으로 시작하는 디렉토리는 건너뜁니다.
        if foldername.endswith('/img') or foldername.startswith('./.idea') or foldername.startswith('./.git'):
            continue

        # 각 폴더에 대해 섹션 헤더를 추가합니다.
        if foldername != '.':
            clean_foldername = foldername.replace('./', '', 1)  # "./" 제거
            readme_file.write(f'## {clean_foldername}\n\n')

        # 각 파일에 대한 리스트 항목을 추가합니다.
        for filename in filenames:
            if filename != 'README.md' and not filename.lower().endswith('.gif'):
                clean_path = os.path.join(foldername, filename).replace('./', '', 1)  # "./" 제거
                url_encoded_path = clean_path.replace(' ', '%20')  # 띄어쓰기를 %20으로 변환

                # git 최초 등록 시간을 가져옵니다.
                date_str = get_git_creation_date(clean_path)
                if date_str:
                    readme_file.write(f'- [{filename}]({url_encoded_path}) ({date_str})\n')
                else:
                    readme_file.write(f'- [{filename}]({url_encoded_path})\n')

        # 서브 폴더 리스트가 비어 있지 않으면 추가 공백 라인을 삽입합니다.
        if subfolders:
            readme_file.write('\n')

print('README.md has been created!')