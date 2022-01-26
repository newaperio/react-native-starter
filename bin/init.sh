#!/usr/bin/env bash

set -e

print_step() {
  echo
  echo "==> $1"
}

print_success() {
  echo
  echo -e "\033[32m> Success:\033[0m $1"
}

print_error() {
  echo -e "\033[31m! Error:\033[0m $1"
}

print_usage() {
  echo
  echo "Usage: $(basename "$0") pascal package"
  echo "  pascal: PascalCase version of new project name, ex: StormNative"
  echo "  package: Package prefix for new project, ex: com.mycompany"
  echo
}

rename() {
  ack -l "$1" --ignore-file=is:init.sh | \
    echo "s/$1/$2/g"
    # xargs sed -i '' -e "s/$1/$2/g"
}

pascal_old="ReactNativeStarter"
package_old="com.reactnative"

pascal_new=$1
package_new=$2


if [[ ! -f "package-lock.json" ]]; then
  print_error "Must be run from project root"
  exit 1
fi

if [[ -z $pascal_new ]]; then
  print_error "Missing \`pascal\` argument"
  print_usage
  exit 1
fi

if [[ -z $package_new ]]; then
  print_error "Missing \`package\` argument"
  print_usage
  exit 1
fi

echo -e "\033[47m\033[36m           < NewAperio >           \033[0m"
echo "React Native Starter Initialization"
echo "-----------------------------------"

print_step "Renaming files"
rename "$name_old" "$name_new"
rename "$package_old" "$package_new"

mv "ios/$pascal_old" "ios/$pascal_new"
mv "ios/$pascal_old.xcodeproj" "ios/$pascal_new.xcodeproj"
mv "ios/$pascal_old.xcodeproj/xcshareddata/xcschemes/$pascal_old.xcscheme" "ios/$pascal_new.xcodeproj/xcshareddata/xcschemes/$pascal_new.xcscheme"
mv "ios/$pascal_old.xcworkspace" "ios/$pascal_new.xcworkspace"
mv "ios/$pascal_oldTests" "ios/$pascal_newTests"
mv "ios/$pascal_oldTests/$pascal_oldTests.m" "ios/$pascal_oldTests/$pascal_newTests.m"

mv "android/app/src/debug/java/com/$package_old" "android/app/src/debug/java/com/$package_new"
mv "android/app/src/main/java/com/$package_old" "android/app/src/main/java/com/$package_new"

print_step "Copying blank README"
mv README_starter.md README.md

print_step "Removing starter specific files"
rm CHANGELOG.md
rm LICENSE

print_step "Removing this script"
rm bin/init.sh

print_success "Complete!"
